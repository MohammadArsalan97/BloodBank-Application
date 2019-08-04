//
//  DonorListVC.swift
//  BloodBankApplication
//
//  Created by Mohammad Arsalan on 04/03/2019.
//  Copyright © 2019 Mohammad Arsalan. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class DonorListVC: UIViewController {
    
    var uid = Auth.auth().currentUser?.uid
    var sharedRef = UIApplication.shared.delegate as! AppDelegate
    var DonorDict : [String:Any] = [:]
    var donor : Donor?
    
    var email = ""
    var name = ""
    var contact_no = ""
    var bloodtype = ""
    var gender = ""
    var dob = ""
    var lastdonation = ""
    var location = ""
    var weight = ""
    var disease = ""
    

    override func viewDidLoad() {
        super.viewDidLoad()
        //getData()
        setUI()
        // Do any additional setup after loading the view.
    }
    
    func setUI() {
        
        
        self.emailLbl.text = self.donor?.email
        self.fullNameLbl.text = self.donor?.name
        self.contactNoLbl.text = self.donor?.contact
        self.bloodTypeLbl.text = self.donor?.bloodtype
        self.genderLbl.text = self.donor?.gender
        
        self.dobLbl.text = self.donor?.dob
        self.dateOfLastDonationLbl.text = self.donor?.dateOfLastDonation
        self.weightLbl.text = self.donor?.weight
        self.bloodDiseasesLbl.text = self.donor?.disease
    }
    
//    func getData()  {
//        let userRef = self.sharedRef.database.collection("Users").document(uid!)
//
//        userRef.getDocument { (document, error) in
//            if let document = document, document.exists {
//                let dataDescription = document.data() as! [String : Any]
//                print("Document data: \(dataDescription)")
//
//
//
//
//            } else {
//                print("Document does not exist")
//            }
//        }
//    }
    
   
    
    @IBAction func callBtn(_ sender: Any) {
    }
    
    @IBAction func chatBtn(_ sender: Any) {
        
        let storyboard: UIStoryboard = UIStoryboard(name: "Chat", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "toChat") as! ChatListVC
        
    self.present(vc, animated: true, completion: nil)
        
    }
    
    @IBOutlet weak var emailLbl: UILabel!
    
    @IBOutlet weak var fullNameLbl: UILabel!
    
    @IBOutlet weak var contactNoLbl: UILabel!
    
    @IBOutlet weak var bloodTypeLbl: UILabel!
    
    @IBOutlet weak var genderLbl: UILabel!
    
    @IBOutlet weak var dobLbl: UILabel!
    
    @IBOutlet weak var dateOfLastDonationLbl: UILabel!
    
    @IBOutlet weak var locationLbl: UILabel!
    
    @IBOutlet weak var weightLbl: UILabel!
    
    @IBOutlet weak var bloodDiseasesLbl: UILabel!
    
}
    

    

