//
//  RequestListVC.swift
//  BloodBankApplication
//
//  Created by Mohammad Arsalan on 04/03/2019.
//  Copyright © 2019 Mohammad Arsalan. All rights reserved.
//

import UIKit
import Firebase

class RequestListVC: UIViewController {
    
    var name = ""
    var date = ""
    var contact = ""
    var bloodtype = ""
    var gender = ""
    var locate = ""

    var sharedRef = UIApplication.shared.delegate as! AppDelegate
    var reqBloodDict : [String:Any] = [:]
    var request : BloodRequest?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hidesBottomBarWhenPushed = true
        setUI()
    }
    
    func setUI() {
        self.NameLbl.text = self.request?.name
        self.genderLbl.text = self.request?.gender
        self.bloodtypeLbl.text = self.request?.bloodtype
        self.contactLbl.text = self.request?.contact
        self.dateLbl.text = self.request?.date
        self.location.text = self.request?.location
    }
    
    
    

    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var NameLbl: UILabel!
    
    @IBOutlet weak var bloodtypeLbl: UILabel!
    
    @IBOutlet weak var contactLbl: UILabel!
    
    @IBOutlet weak var dateLbl: UILabel!
    
    @IBOutlet weak var genderLbl: UILabel!
    
    @IBOutlet weak var location: UILabel!
}
