//
//  ChatViewController.swift
//  BloodBankApplication
//
//  Created by Mohammad Arsalan on 04/03/2019.
//  Copyright © 2019 Mohammad Arsalan. All rights reserved.
//

import UIKit
import SDWebImage
import FirebaseAuth
import FirebaseStorage
import Firebase

class ChatViewController: UIViewController {
    
    var uid = Auth.auth().currentUser?.uid
    var sharedRef = UIApplication.shared.delegate as! AppDelegate
    var chatUserData : [ChatUser] = []
    var chatDictionary = [String:ChatUser]()
    var chatUserObject : ChatUser?
    var timeStamp: Date?
    var name = ""
    var imgUrl = ""
    var message = ""
    var image = #imageLiteral(resourceName: "icons8-user-40")
    var recipientID : String?
    var isSender  = false

    override func viewDidLoad() {
        super.viewDidLoad()
   
        chatTableView.delegate = self
        chatTableView.dataSource = self
        configureTableView()
        retrieveMessages()
    }
    
    func configureTableView()  {
        chatTableView.rowHeight = UITableViewAutomaticDimension
        chatTableView.estimatedRowHeight = 120.0
    }
    
    
    func retrieveMessages() {
 
        let messageDB = self.sharedRef.database.collection("Conversation").document(self.uid!).collection("Inbox").addSnapshotListener { querySnapshot, error in
                guard let snapshot = querySnapshot else {
                    print("Error fetching snapshots: \(error!)")
                    return
                }
                snapshot.documentChanges.forEach { diff in
                    if (diff.type == .added) {
                        
                        
                        self.recipientID = diff.document.data()["recipientID"] as! String
                        self.message = diff.document.data()["message"] as! String
                        var convoID = diff.document.data()["conversationID"] as! String
                        
                        var date : Date?
                        var getDate : Timestamp?
                        if let timestamp = diff.document.data()["time"] as? Timestamp{
                            date = timestamp.dateValue()
                            print(date)
                        }else{
                            date = Date()
                        }
                        let formatter = DateFormatter()
                        formatter.dateStyle = .none
                        formatter.timeStyle = .short
                        let str = formatter.string(from: date!)
                        print(str)
                        print(date)
                        
//                        let result = convoID.split(separator: "_")
//                        print(result)
//                        let parsed = convoID.replacingOccurrences(of: "_", with: "")
//                        let againParsed = parsed.replacingOccurrences(of: self.uid!, with: "")
//                        print(parsed)
//                        print(againParsed)
//                        if againParsed == self.uid{
//                            print(self.uid!)
//                        }else{
//
//                        }
                        
                        self.name = diff.document.data()["recipientName"] as! String
                        self.imgUrl = diff.document.data()["recepientImageUrl"] as! String
                        
                        
                        
                        print(self.name,self.message)
                        print(self.imgUrl)

                        self.chatUserObject = ChatUser(name: self.name, message: self.message, imageURL: self.imgUrl, recipientID: self.recipientID!, conversationID: convoID, time: str)
                        self.chatUserData.append(self.chatUserObject!)

                        DispatchQueue.main.async{
                            self.chatTableView.reloadData()
                        }
                        
                    }
                    if (diff.type == .modified) {
                        
                       
                        
                        self.name = diff.document.data()["recipientName"] as! String
                        self.message = diff.document.data()["message"] as! String
                        print(self.name,self.message)
                        
                        self.chatUserData.filter {$0.name == self.name}.first?.message = self.message
                        
                        
                        
                        self.chatTableView.reloadData()
                    }
                }
            }
                
    }
 
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toChatListVC" {
            let destVC = segue.destination as! ChatListVC
            destVC.chat = sender as! ChatUser?
            destVC.hidesBottomBarWhenPushed = true
            destVC.navigationItem.title = destVC.chat?.name
            
        }
        
    }

    @IBOutlet weak var chatTableView: UITableView!
    
    
}
extension ChatViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chatUserData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChatCell") as! ChatCell
        
        cell.nameLbl.text = self.chatUserData[indexPath.row].name
        cell.messageLbl.text = self.chatUserData[indexPath.row].message
       // cell.chatUserImageView.image = self.image
        cell.timeLbl.text = self.chatUserData[indexPath.row].time
        let url = URL(string: self.chatUserData[indexPath.row].imageURL)
        cell.chatUserImageView.sd_setImage(with: url as! URL, placeholderImage: self.image)
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let chat = self.chatUserData[indexPath.row]
        performSegue(withIdentifier: "toChatListVC", sender: chat)
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 72
    }
    
    
    
    
}

