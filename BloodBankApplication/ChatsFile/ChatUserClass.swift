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
    var time : String
    var image : UIImage
    var count : Int
    
    init(name : String, message : String, time : String, image : UIImage, count : Int) {
        self.name = name
        self.message = message
        self.time = time
        self.image = image
        self.count = count
    }
    
}
