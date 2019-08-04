//
//  CustomTextField.swift
//  BloodBankApplication
//
//  Created by Mohammad Arsalan on 04/03/2019.
//  Copyright © 2019 Mohammad Arsalan. All rights reserved.
//

import UIKit

@IBDesignable class CustomTextField: UITextField,UITextFieldDelegate {


        
        
        @IBInspectable var lineColor:UIColor = UIColor.red
        @IBInspectable var lineHeight:CGFloat = 1
        
        override func draw(_ rect: CGRect) {
            let line = CALayer()
            line.frame = CGRect(x: 0, y: self.frame.height - lineHeight, width: self.frame.width, height: self.frame.height)
            
            line.borderColor = lineColor.cgColor
            line.borderWidth = lineHeight
            self.layer.addSublayer(line)
            self.layer.masksToBounds = true
            setNeedsDisplay()
        }
}
