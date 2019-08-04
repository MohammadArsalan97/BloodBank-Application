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
    var sender : String
    var messageBody : String
//    var time : String
//    var image : UIImage
//    var count : Int
    
    init(sender : String, messageBody : String) {
        self.sender = sender
        self.messageBody = messageBody
    }
    
}
