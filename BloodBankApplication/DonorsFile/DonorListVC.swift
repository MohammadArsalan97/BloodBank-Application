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
import FirebaseFirestore
import SDWebImage

class DonorListVC: UIViewController {
    
    var uid = Auth.auth().currentUser?.uid
    var sharedRef = UIApplication.shared.delegate as! AppDelegate
    var DonorDict : [String:Any] = [:]
    var conversationID = ""
    
    
    var donor : Donor?
    
    
    //var userId = ""
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
    var imageURL = ""
    var userImage = #imageLiteral(resourceName: "icons8-user-40")
    

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
        self.imageURL = (self.donor?.imageURL)!
        
        let url = URL(string: self.imageURL)
        userImageiew.sd_setImage(with: url as! URL, placeholderImage: self.userImage)
    }
    
    @IBAction func callBtn(_ sender: Any) {
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "tochatSegue" {
            let destVC = segue.destination as! ChatListVC
            destVC.navigationItem.title = self.donor?.name
            destVC.recipientName = self.donor?.name
            destVC.recipientID = self.donor?.userID
            destVC.recipientImageUrl = self.donor?.imageURL
           // destVC.conversationID = self.conversationID
        }
    }
    
    @IBAction func chatBtn(_ sender: Any) {
        self.performSegue(withIdentifier: "tochatSegue", sender: self)
    }
    
    
    @IBOutlet weak var chatBtnOutlet: UIButton!{
        didSet{
            chatBtnOutlet.layer.cornerRadius  = 5
        }
    }
    @IBOutlet weak var callBtnOutlet: UIButton!{
        didSet{
            callBtnOutlet.layer.cornerRadius  = 5
        }
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
    
    @IBOutlet weak var userImageiew: CustomImageView!
    
    
    
    
}
    

    

