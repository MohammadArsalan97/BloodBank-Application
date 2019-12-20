//
//  ReceiverCell.swift
//  BloodBankApplication
//
//  Created by Mohammad Arsalan on 05/10/2019.
//  Copyright © 2019 Mohammad Arsalan. All rights reserved.
//

import UIKit

class ReceiverCell: UITableViewCell {

    @IBOutlet weak var receiverMessageBody: UILabel!
    
    @IBOutlet weak var receiverCellView: UIView!{
        didSet{
            receiverCellView.layer.cornerRadius  = 10
            //cellView.frame = CGRect(x: 0, y: 0, width: 300, height: )
        }
    }
    @IBOutlet weak var time: UILabel!
}
