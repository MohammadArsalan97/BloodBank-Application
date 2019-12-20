//
//  RoundButton.swift
//  BloodBankApplication
//
//  Created by Mohammad Arsalan on 05/09/2019.
//  Copyright © 2019 Mohammad Arsalan. All rights reserved.
//

import UIKit

@IBDesignable class RoundButton: UIButton {

    
    @IBInspectable var ISCircle: Bool = false {
        didSet {
            setButtonInCircle()
        }
    }
    
    
    func setButtonInCircle()
    {
        if ISCircle {
            //self.layer.borderWidth
            self.layer.masksToBounds = false
            //image.layer.borderColor = UIColor.black.cgColor
            self.layer.cornerRadius = self.frame.height/2
            self.clipsToBounds = true
        } else {
            // self.layer.masksToBounds = false
            //image.layer.borderColor = UIColor.black.cgColor
            self.layer.cornerRadius = 0
            //self.clipsToBounds = true
        }
        
        
    }
}

