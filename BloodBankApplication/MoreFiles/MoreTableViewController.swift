//
//  MoreTableViewController.swift
//  BloodBankApplication
//
//  Created by Mohammad Arsalan on 10/07/2019.
//  Copyright © 2019 Mohammad Arsalan. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import FirebaseAuth

class MoreTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
   override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        print(indexPath.row)
    
    if indexPath.row == 4 {
        showActionSheet()
        }
    
    }

    func showActionSheet() {
        
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        cancel.setValue(UIColor.red, forKey: "titleTextColor")
        let logout = UIAlertAction(title: "Logout", style: .default) { (action) in
            let firebaseAuth = Auth.auth()
            
            do {
                try firebaseAuth.signOut()
                let vc = self.navigationController?.navigationController?.popToRootViewController(animated: true)
                
            } catch let signOutError as NSError {
                print ("Error signing out: %@", signOutError)
            }
        }
     
        actionSheet.addAction(logout)
        
        
        actionSheet.addAction(cancel)
        
        present(actionSheet, animated: true, completion: nil)
    }
    
    }

