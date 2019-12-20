//
//  DonorClass.swift
//  BloodBankApplication
//
//  Created by Mohammad Arsalan on 13/03/2019.
//  Copyright © 2019 Mohammad Arsalan. All rights reserved.
//

import Foundation
import UIKit

class Donor {
    
    var userID: String
    var name : String
    var email : String
    var dob : String
    var contact : String
    var bloodtype : String
    var gender : String
    var dateOfLastDonation : String
    var disease : String
    var hemoglobinLevel : String
    var weight : String
    var imageURL : String
    //var image : UIImage

    
    init(userID: String,name: String,email: String,dob:String,contact: String,bloodtype:String,gender:String,dateOfLastDonation:String,disease:String,hemoglobinLevel:String,weight:String,imageURL: String) {
        
        self.userID = userID
        self.name = name
        self.email = email
        self.dob = dob
        self.contact = contact
        self.bloodtype = bloodtype
        self.gender = gender
        self.dateOfLastDonation = dateOfLastDonation
        self.disease = disease
        self.hemoglobinLevel = hemoglobinLevel
        self.weight = weight
        self.imageURL = imageURL
        //self.image = image
    }
}
