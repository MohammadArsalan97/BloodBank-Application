//
//  Alert.swift
//  BloodBankApplication
//
//  Created by Mohammad Arsalan on 04/04/2019.
//  Copyright © 2019 Mohammad Arsalan. All rights reserved.
//

import Foundation
import UIKit

struct Alert {
    
    private static func showBasicAlert(on vc: UIViewController, with title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        DispatchQueue.main.async { vc.present(alert, animated: true) }
    }
    
    
    static func showIncompleteFormAlert(on vc: UIViewController) {
        showBasicAlert(on: vc, with: "Incomplete Form", message: "Please fill out all fields")
    }
    
//    static func showInvalidEmailAlert(on vc: UIViewController) {
//        showBasicAlert(on: vc, with: "Invalid Email", message: "Please use a correct email")
//    }
    static func showErrorAlert(on vc: UIViewController, message: String){
        showBasicAlert(on: vc, with: "Error", message: message)
    }
    
    static func showUnableToRetrieveDataAlert(on vc: UIViewController) {
        showBasicAlert(on: vc, with: "Unable to Retrieve Data", message: "Network Error")
    }
    
    
}
