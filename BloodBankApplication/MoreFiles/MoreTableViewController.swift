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
        let firebaseAuth = Auth.auth()
        //let signoutAction = UIAlertAction(title: "Sign Out", style: .destructive) { (action) in
        
        do {
                try firebaseAuth.signOut()
                self.navigationController?.navigationController?.popToRootViewController(animated: true)
                
            } catch let signOutError as NSError {
                print ("Error signing out: %@", signOutError)
                }
        }
    
    }

    }

