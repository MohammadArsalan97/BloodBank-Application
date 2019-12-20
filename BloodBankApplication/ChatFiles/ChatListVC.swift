//
//  ChatListVC.swift
//  BloodBankApplication
//
//  Created by Mohammad Arsalan on 04/03/2019.
//  Copyright © 2019 Mohammad Arsalan. All rights reserved.
//

import UIKit
//import Firebase
import FirebaseAuth
import FirebaseFirestore

class ChatListVC: UIViewController {

    var sharedRef = UIApplication.shared.delegate as! AppDelegate
    var messageArray : [Message] = [Message]()
    var userDataDict = [String:Any]()
    var chat : ChatUser?
    var sortedArray : [Message] = []
    var timeArray : [String] = []


    var userArray : [String] = []
    {
        didSet
        {
            self.userArray.sort{ (a,b) -> Bool in return a > b }
        }
    }
    
    var convoID = ""
    
    var sender = ""
    var msg = ""
    var isSender = true
    //var conversationID = ""
    
    let uid = Auth.auth().currentUser?.uid
    
    var recipientName : String?
    var recipientID : String?
    var recipientImageUrl : String?
    
    var recieverName = ""
    var recieverID = ""
    var recieverImageUrl = ""

   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
        print(recipientName)
        print(recipientID)
        print(recipientImageUrl)
        
        if let conversationID = chat?.conversationID{
            convoID = conversationID
            print(convoID)
        }
        
        //conversationID = (chat?.conversationID)!
        //--------------
        if let recipientId = recipientID{
            recieverID = recipientId
            print(recieverID)
        }
        if let recipientId = chat?.recipientID{
            recieverID = recipientId
            print(recieverID)
        }
        //----------------
        if let recipientname = recipientName{
            recieverName = recipientname
            print(recieverName)
        }
        if let recipientname = chat?.name{
            recieverName = recipientname
            print(recieverName)
        }
        
        if let recipientURL = recipientImageUrl{
            recieverImageUrl = recipientURL
            print(recieverImageUrl)
        }
        if let recipientURL = chat?.imageURL{
            recieverImageUrl = recipientURL
            print(recieverImageUrl)
        }
        
//        recieverName = recipientName
//        recieverImageUrl = recipientImageUrl
        //convoID = conversationID
        //print(convoID)
        
//        let result = convoID.split(separator: "_")
//        print(result)
        
        messageTableView.delegate = self
        messageTableView.dataSource = self
        messageTextField.delegate = self
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tableViewTapped))
        messageTableView.addGestureRecognizer(tapGesture)
        
        
        
        configureTableView()
        retrieveMessages()
//        retrieveMessages(completion: (msgArr,error) in
//        guard let msgArr = self.sortedArray else
//        {
//            print(error)
//            return
//        }
//            )

    
    }
    
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var sendButton: UIButton!
    
    @IBOutlet weak var messageTextField: UITextField!
    @IBOutlet weak var messageTableView: UITableView!
    
    
    func getData() {
        let docRef = self.sharedRef.database.collection("Users").document(self.uid!)
        
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                self.userDataDict = document.data()!
                print("Document data: \(self.userDataDict)")
            } else {
                print("Document does not exist")
            }
        }
    }
    func configureTableView()  {
        messageTableView.rowHeight = UITableViewAutomaticDimension
        messageTableView.estimatedRowHeight = 120.0
    }
    
    @IBAction func sendButton(_ sender: Any) {
        
        messageTextField.endEditing(true)
        messageTextField.isEnabled = false
        sendButton.isEnabled = false
        
        // Add conversation collection
        var Users = [String]()
        Users.append(self.uid!)
        Users.append(self.recieverID)
        
        print(self.recieverID)
//        userArray[0] = self.uid!
//        userArray[1] = self.recieverID
        
        userArray.append(self.uid!)
        userArray.append(self.recieverID)
        print(userArray)
        
        print(userArray[0])
        print(userArray[1])
        
        print (self.recieverID)
        convoID = userArray[0]+"_"+userArray[1]
        print(convoID)
       // var conversaionID = [String]()
        
        let senderConversationDict: [String:Any] = [
            "message" : messageTextField.text!,
            "recipientName" : self.recieverName,
            "recipientID" : self.recieverID,
            "recepientImageUrl" : self.recieverImageUrl,
            "senderID": self.uid,
            "senderName" : userDataDict["name"],
            "senderImageUrl" : userDataDict["imageUrl"],
            "conversationID" : self.convoID,
            "users" : Users,
            "isSender" : isSender,
            "time" : FieldValue.serverTimestamp()
        ]
        let recieverConversationDict: [String:Any] = [
            "message" : messageTextField.text!,
            "recipientName" : userDataDict["name"],
            "recipientID" : self.uid,
            "recepientImageUrl" : userDataDict["imageUrl"],
//            "senderID": ,
//            "senderName" : ,
//            "senderImageUrl" : ,
            "isSender" : false,
            "conversationID" : self.convoID,
            "users" : Users,
            "time" : FieldValue.serverTimestamp()
        ]
        
        
        // add Chat collection
        let dict: [String:Any] = [
            "isSender" : self.isSender,
            "senderID" : self.uid,
            "messageContent" : messageTextField.text!,
            "recipientID": self.recieverID,
            "recipientName" : self.recieverName,
            "recipientImageUrl" :self.recieverImageUrl,
            "timeStamp" : FieldValue.serverTimestamp(),
            "conversationID" : self.convoID
    ]
        
        // Get new write batch
        let batch = self.sharedRef.database.batch()
      
        // Set the value of 'ConversationID'
        let senderRef = self.sharedRef.database.collection("Conversation").document(self.uid!).collection("Inbox").document(self.recieverID)
        batch.setData(senderConversationDict, forDocument: senderRef)
        
        // Set the value of 'ConversationID'
        let receiverRef = self.sharedRef.database.collection("Conversation").document(self.recieverID).collection("Inbox").document(self.uid!)
        batch.setData(recieverConversationDict, forDocument: receiverRef)
        
        // Set the value of 'Chat'
        let chatDocRef = self.sharedRef.database.collection("Chat").document()
        batch.setData(dict, forDocument: chatDocRef)
        
        // Commit the batch
        batch.commit() { err in
            if let err = err {
                print("Error writing batch \(err)")
            } else {
                print("Batch write succeeded.")
                self.userArray.removeAll()
                
                self.messageTextField.isEnabled = true
                self.sendButton.isEnabled = true
                self.messageTextField.text = ""
            }
        }
        
    }
   
    
//    completion:@escaping([Message?],String?)->Void
    
    func retrieveMessages() {
        let messageDB = self.sharedRef.database.collection("Chat").whereField("conversationID", isEqualTo: self.convoID).addSnapshotListener { querySnapshot, error in
                guard let snapshot = querySnapshot else {
                    print("Error fetching snapshots: \(error!)")
                    return
                }
        
                snapshot.documentChanges.forEach { diff in
                    if (diff.type == .added) {
                        self.sender = diff.document.data()["senderID"]! as! String
                        self.msg = diff.document.data()["messageContent"]! as! String
                        let conID = diff.document.data()["conversationID"]!
                        self.isSender = diff.document.data()["isSender"]! as! Bool
                        let reciID = diff.document.data()["recipientID"]! as! String
                        var date : Date?
                        var getDate : Timestamp?
                        if let timestamp = diff.document.data()["timeStamp"] as? Timestamp{
                            date = timestamp.dateValue()
                            print(date)
                        }else{
                            date = Date()
                        }
                        
//                        let getDate = diff.document.data()["timeStamp"] as! Timestamp
//                        let date = getDate.dateValue()
                        // Date format for sorting messages
                        let dateFormatter = DateFormatter()
                        dateFormatter.dateStyle = .short
                        dateFormatter.timeStyle = .short
                        let strDate = dateFormatter.string(from: date!)
                        print(strDate)
                        print(date)
                        
                        // Time Format For showing on message
                        let timeFormatter = DateFormatter()
                        timeFormatter.dateStyle = .none
                        timeFormatter.timeStyle = .short
                        let strTime = timeFormatter.string(from: date!)
                        print(strTime)
                        print(date)
//                        self.timeArray.append(str)
//                        self.timeArray.sort()
//                        print(self.timeArray)
                        
//                        self.timeArray.append(date!)
//                        self.timeArray.sort()
//                        print(self.timeArray)
                        
                        let message = Message(senderID: self.sender, messageBody: self.msg, isSender: self.isSender, convoID: conID as! String, recipientID: reciID, time: strTime, date: strDate)
                        self.messageArray.append(message)
                        
                        self.messageArray = self.messageArray.sorted(by: { $0.date < $1.date })
                        
                        
                        

                        self.configureTableView()
                        self.messageTableView.reloadData()
                    }   
                    //completion(self.sortedArray,nil)
                }
        }
        
        }
    }

extension ChatListVC: UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messageArray.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MessageCell", for: indexPath) as! MessageCell
        let receiverCell = tableView.dequeueReusableCell(withIdentifier: "ReceiverCell", for: indexPath) as! ReceiverCell
        
        ////////////////////////////////////////////
//        let result = messageArray[indexPath.row].convoID.split(separator: "_")
//        print(result)
//        let parsed = messageArray[indexPath.row].convoID.replacingOccurrences(of: "_", with: "")
//        let againParsed = parsed.replacingOccurrences(of: self.uid!, with: "")
//        print(parsed)
//        print(againParsed)
//        print(messageArray[indexPath.row].time)
//        if againParsed == self.recieverID{
//            isSender = false
//        }else{
//            isSender = true
//        }
        if messageArray[indexPath.row].senderID == self.uid{
            cell.messageBody.text = messageArray[indexPath.row].messageBody
            cell.time.text = messageArray[indexPath.row].time
            return cell
        }
        else{
            receiverCell.receiverMessageBody.text = messageArray[indexPath.row].messageBody
            receiverCell.time.text = messageArray[indexPath.row].time
            return receiverCell
        }
        
//        if isSender == true{
//            cell.messageBody.text = messageArray[indexPath.row].messageBody
//        }else{
//            receiverCell.receiverMessageBody.text = messageArray[indexPath.row].messageBody
//        }
        
        
        //return cell
    }
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 72
//    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    
    @objc func tableViewTapped(){
        messageTextField.endEditing(true)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        
        UIView.animate(withDuration: 0.5) {
            self.heightConstraint.constant = 313
            self.view.layoutIfNeeded()
        }
    }
    
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        UIView.animate(withDuration: 0.5) {
            self.heightConstraint.constant = 55
            self.view.layoutIfNeeded()
        }
    }
}
