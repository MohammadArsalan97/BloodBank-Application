//
//  MessageClass.swift
//  BloodBankApplication
//
//  Created by Mohammad Arsalan on 22/07/2019.
//  Copyright © 2019 Mohammad Arsalan. All rights reserved.
//

import Foundation
import UIKit

class Message {
    var senderID : String
    var messageBody : String
    var isSender : Bool
    var convoID : String
    var recipientID : String
    var time : String
    var date : String
//    var image : UIImage
//    var count : Int
    
    init(senderID : String, messageBody : String, isSender : Bool, convoID : String, recipientID : String, time : String, date : String) {
        self.senderID = senderID
        self.messageBody = messageBody
        self.isSender = isSender
        self.convoID = convoID
        self.recipientID = recipientID
        self.time = time
        self.date = date
    }
    
}
