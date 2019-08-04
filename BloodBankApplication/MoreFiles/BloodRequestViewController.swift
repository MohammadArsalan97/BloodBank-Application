//
//  BloodRequestViewController.swift
//  BloodBankApplication
//
//  Created by Mohammad Arsalan on 04/03/2019.
//  Copyright © 2019 Mohammad Arsalan. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class BloodRequestViewController: UIViewController {
 
    var sharedRef = UIApplication.shared.delegate as! AppDelegate
    let uid = Auth.auth().currentUser?.uid
//    var reqName = ""
//    var reqBloodtype = ""
//    var reqDate = ""
//    var reqContact = ""
//    var reqLocation = ""
//    var reqGender = ""
   // var dictData = [String:Any]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBOutlet weak var bloodtype: CustomTextField!
    @IBOutlet weak var date: CustomTextField!
    
    @IBOutlet weak var contact: CustomTextField!
    
    @IBOutlet weak var location: CustomTextField!
    
    @IBOutlet weak var name: CustomTextField!
    
    @IBOutlet weak var gender: CustomTextField!
    
    @IBAction func submitBtn(_ sender: Any) {
        
        guard let reqName = name.text,let reqBloodtype = bloodtype.text, let reqDate = date.text, let reqContact = contact.text, let reqLocation = location.text, let reqGender = gender.text, let uid = self.uid else {
            return
            
        }
            
           let dict : [String:Any] = [
            
            "name" : reqName,
            "bloodtype" : reqBloodtype,
            "date" : reqDate,
            "contact" : reqContact,
            "location" : reqLocation,
            "gender" : reqGender,
            "uid" : uid
            ]
        
        self.sharedRef.database.collection("RequestBlood").addDocument(data: dict) { (error) in
            if error == nil{
                print("data save")
            }else{
                print("error",error)
            }
        }
        
        }
        
        
    
    }

