//
//  ChatListVC.swift
//  BloodBankApplication
//
//  Created by Mohammad Arsalan on 04/03/2019.
//  Copyright © 2019 Mohammad Arsalan. All rights reserved.
//

import UIKit
import Firebase

class ChatListVC: UIViewController {

    var sharedRef = UIApplication.shared.delegate as! AppDelegate
    
    var message : [Message] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "The title"

        messageTableView.delegate = self
        messageTableView.dataSource = self
        messageTextField.delegate = self
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tableViewTapped))
        messageTableView.addGestureRecognizer(tapGesture)
        
        configureTableView()
    
        // Do any additional setup after loading the view.
    }

    
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var sendButton: UIButton!
    
    @IBOutlet weak var messageTextField: UITextField!
    @IBOutlet weak var messageTableView: UITableView!
    
    @IBAction func sendButton(_ sender: Any) {
        
        messageTextField.endEditing(true)
        messageTextField.isEnabled = false
        sendButton.isEnabled = false
        
        let dict: [String:Any] = [
            "sender" : Auth.auth().currentUser?.uid,
            "messageBody" : messageTextField.text!
        ]
        self.sharedRef.database.collection("Chat").addDocument(data: dict) { (error) in
            if error != nil{
                print(error!)
            }
            else{
                print("Message saved successfully!")
                
                self.messageTextField.isEnabled = true
                self.sendButton.isEnabled = true
                self.messageTextField.text = ""
            }
        }
        
    }
    
    func configureTableView()  {
        messageTableView.rowHeight = UITableViewAutomaticDimension
        messageTableView.estimatedRowHeight = 120.0
    }
}

extension ChatListVC: UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MessageCell", for: indexPath) as! MessageCell
        
        //let messageArray = ["abc","dfs", "asd"]
        cell.senderMessageLbl.text = "111"
        
        if indexPath.row % 2 == 0
        {
            cell.senderMessageLbl.text = "zzzz"
            return cell
        }
        else
        {
            cell.senderMessageLbl.text = "SSSS"
            return cell
        }
        
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
