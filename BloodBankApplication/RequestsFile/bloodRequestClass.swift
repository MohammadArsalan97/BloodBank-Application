//
//  bloodRequestClass.swift
//  BloodBankApplication
//
//  Created by Mohammad Arsalan on 16/07/2019.
//  Copyright © 2019 Mohammad Arsalan. All rights reserved.
//

import Foundation
class BloodRequest {
    var name : String
    var gender : String
    var bloodtype : String
    var contact : String
    var date : String
    var location : String
    
    init(name : String, gender : String, bloodtype : String, contact : String, date : String, location : String) {
        self.name = name
        self.gender = gender
        self.bloodtype = bloodtype
        self.contact = contact
        self.date = date
        self.location = location
    }
}
