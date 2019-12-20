//
//  CustomViewForChatBubble.swift
//  BloodBankApplication
//
//  Created by Mohammad Arsalan on 14/09/2019.
//  Copyright © 2019 Mohammad Arsalan. All rights reserved.
//

import UIKit

@IBDesignable class CustomViewForChatBubble: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    
    
//    @IBInspectable var borderColor: UIColor = UIColor.white {
//        didSet {
//            self.layer.borderColor = borderColor.cgColor
//        }
//    }
//    
//    @IBInspectable var borderWidth: CGFloat = 2.0 {
//        didSet {
//            self.layer.borderWidth = borderWidth
//        }
//    }
    
    @IBInspectable var cornerRadius: CGFloat = 0.0 {
        didSet {
            self.layer.cornerRadius = cornerRadius
        }
    }

}
