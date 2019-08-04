//
//  DonorCell.swift
//  BloodBankApplication
//
//  Created by Mohammad Arsalan on 13/03/2019.
//  Copyright © 2019 Mohammad Arsalan. All rights reserved.
//

import UIKit

class DonorCell: UITableViewCell {
    

    @IBOutlet weak var DonorName: UILabel!
    
    @IBOutlet weak var DonorImageView: UIImageView!
    
    @IBOutlet weak var locationLabel: UILabel!
    
    @IBOutlet weak var locationImageView: UIImageView!
    
    @IBOutlet weak var bloodTypeLabel: UILabel!
    
    func setDonor(donor : Donor) {
        DonorName.text = donor.name
        bloodTypeLabel.text = donor.bloodtype
    }
}
