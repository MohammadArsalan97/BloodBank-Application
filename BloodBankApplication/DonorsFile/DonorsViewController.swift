//
//  DonorsViewController.swift
//  BloodBankApplication
//
//  Created by Mohammad Arsalan on 04/03/2019.
//  Copyright © 2019 Mohammad Arsalan. All rights reserved.
//

import UIKit
import Firebase
import Foundation
import FirebaseAuth

class DonorsViewController: UIViewController {
    
    var uid = Auth.auth().currentUser?.uid
    var sharedRef = UIApplication.shared.delegate as! AppDelegate
    //var dictData = [String:Any]()
    var donorData : [Donor] = []
    var donorObject : Donor?
    
    var name = ""
    var email = ""
    var dob = ""
    var contact = ""
    var bloodtype = ""
    var gender = ""
    var dateOfLastDonation = "NA"
    var disease = "NA"
    var hemoglobinLevel = "NA"
    var weight = "NA"
    
//    var tmpUser:User?
//    var currentUser = [User]()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        donorTableView.reloadData()
        getData()
     //  donor = createArray()
        donorTableView.delegate = self
        donorTableView.dataSource = self
    }
    
  
    
    
    
    
    func getData() {
        let userRef = self.sharedRef.database.collection("Users").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    print("\(document.documentID) => \(document.data())")
                    var dataDescription = document.data()
                    self.name = dataDescription["name"] as! String
                    self.bloodtype = dataDescription["bloodtype"] as! String
                    self.email = dataDescription["email"] as! String
                    self.contact = dataDescription["Contact"] as! String
                    self.dob = dataDescription["dob"] as! String
                    self.gender = dataDescription["gender"] as! String
                    self.dateOfLastDonation = dataDescription["date of last donation"] as! String
                    self.disease = dataDescription["disease(s)"] as! String
                    self.hemoglobinLevel = dataDescription["hemoglobin Level"] as! String
                    self.weight = dataDescription["weight"] as! String
                    
                    self.donorObject = Donor(name: self.name, email: self.email, dob: self.dob, contact: self.contact, bloodtype: self.bloodtype, gender: self.gender, dateOfLastDonation: self.dateOfLastDonation, disease: self.disease, hemoglobinLevel: self.hemoglobinLevel, weight: self.weight)
                    self.donorData.append(self.donorObject!)
                    self.donorTableView.reloadData()
                }
            }
        }
//        userRef.getDocument { (document, error) in
//            if let document = document, document.exists {
//                let dataDescription = document.data() as! [String: Any]
//                //self.donor.append(dataDescription) as! User
//
//                self.name = dataDescription["name"] as! String
//                self.bloodtype = dataDescription["bloodtype"] as! String
//                self.email = dataDescription["email"] as! String
//                self.contact = dataDescription["Contact"] as! String
//                self.dob = dataDescription["dob"] as! String
//                self.gender = dataDescription["gender"] as! String
//                self.dateOfLastDonation = dataDescription["date of last donation"] as! String
//                self.disease = dataDescription["disease(s)"] as! String
//                self.hemoglobinLevel = dataDescription["hemoglobin Level"] as! String
//                self.weight = dataDescription["weight"] as! String
//
//
//
//                self.tmpUser = User(name: self.name, email: self.email, dob: self.dob, contact: self.contact, bloodtype: self.bloodtype, gender: self.gender, dateOfLastDonation: self.dateOfLastDonation, disease: self.disease, hemoglobinLevel: self.hemoglobinLevel, weight: self.weight)
//
//                self.currentUser.append(self.tmpUser!)
//                //   self.dictData = [ "donorArray":self.tmpUser!]
//                //self.sharedRef.database.collection("Users").document(self.uid!).updateData(self.dictData)
//
//
//                print("Document data: \(dataDescription)")
//                //  self.name = dataDescription["name"] as! String
//
//                // self.bloodtype = dataDescription["bloodtype"] as! String
//                //print(self.name)
//                // print(self.bloodtype)
//
//                self.donorTableView.reloadData()
//            } else {
//                print("Document does not exist")
//            }
//        }
//
        
    }
   

    @IBOutlet weak var donorTableView: UITableView!
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDonorProfile" {
            let destVC = segue.destination as! DonorListVC
            destVC.donor = sender as! Donor
            
        }
        
    }
    
}

extension DonorsViewController: UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return donorData.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
  //      let d = currentUser[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "DonorCell") as! DonorCell
        
        cell.DonorName.text = self.donorData[indexPath.row].name
        cell.bloodTypeLabel.text = self.donorData[indexPath.row].bloodtype
      //  cell.setDonor(donor: d)
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let donor = self.donorData[indexPath.row]
        performSegue(withIdentifier: "toDonorProfile", sender: donor)
    }


}

