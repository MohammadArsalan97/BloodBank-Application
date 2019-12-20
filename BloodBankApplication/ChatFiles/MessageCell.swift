//
//  MessageCell.swift
//  BloodBankApplication
//
//  Created by Mohammad Arsalan on 22/07/2019.
//  Copyright © 2019 Mohammad Arsalan. All rights reserved.
//

import UIKit

class MessageCell: UITableViewCell {

   
    //@IBOutlet weak var messageBackground: CustomViewForChatBubble!
    @IBOutlet weak var messageBody: UILabel!
    
    @IBOutlet weak var cellView: UIView!{
        didSet{
            cellView.layer.cornerRadius  = 10
            //cellView.frame = CGRect(x: 0, y: 0, width: 300, height: )
        }
    }
    @IBOutlet weak var time: UILabel!
    

    
}
