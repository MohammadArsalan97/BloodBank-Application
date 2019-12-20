//
//  ChatUserClass.swift
//  BloodBankApplication
//
//  Created by Mohammad Arsalan on 25/07/2019.
//  Copyright © 2019 Mohammad Arsalan. All rights reserved.
//

import Foundation
import  UIKit

class ChatUser {
    var name : String
    var message : String
    var recipientID : String
    var conversationID : String
    var time : String
    var imageURL : String
    //var count : Int
    
    init(name : String, message: String,imageURL : String,recipientID : String, conversationID : String, time : String) {
        self.conversationID = conversationID
        self.recipientID = recipientID
        self.imageURL = imageURL
        self.name = name
        self.message = message
        self.time = time
        //self.imageURL = imageURL
        //self.count = count
    }
    
}
