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
import FirebaseStorage
import SDWebImage
import SVProgressHUD


class DonorsViewController: UIViewController {
    
    
    @IBOutlet weak var searchBtnOutlet: RoundButton!
    @IBAction func searchButton(_ sender: Any) {
        showActionSheet()
    }

    func getDataWithBloodGroup(bloodtype: String){
        self.donorData.removeAll()
        self.sharedRef.database.collection("Users").whereField("bloodtype", isEqualTo: bloodtype)
            .getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    for document in querySnapshot!.documents {
                        
                        print("\(document.documentID) => \(document.data())")
                        var dataDescription = document.data()
                        self.userId = dataDescription["userId"] as! String
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
                        self.imageURL = (dataDescription["imageUrl"] as? String)!
                        
                        
                        // self.downloadImageFromFirebase()
                        
                        self.donorObject = Donor(userID: self.userId, name: self.name, email: self.email, dob: self.dob, contact: self.contact, bloodtype: self.bloodtype, gender: self.gender, dateOfLastDonation: self.dateOfLastDonation, disease: self.disease, hemoglobinLevel: self.hemoglobinLevel, weight: self.weight, imageURL: self.imageURL )
                        self.donorData.append(self.donorObject!)
                        self.donorTableView.reloadData()
                    }
                }
        }
    }
    
    
    func showActionSheet() {
        
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        let bloodType1 = UIAlertAction(title: "A+", style: .default) { (action) in
            
            self.getDataWithBloodGroup(bloodtype: "A+")
            self.searchBtnOutlet.setTitle("A+",for: .normal)
        }
        let bloodType2 = UIAlertAction(title: "A-", style: .default) { (action) in
            self.getDataWithBloodGroup(bloodtype: "A-")
            self.searchBtnOutlet.setTitle("A-",for: .normal)
        }
        let bloodType3 = UIAlertAction(title: "O+", style: .default) { (action) in
            self.getDataWithBloodGroup(bloodtype: "O+")
            self.searchBtnOutlet.setTitle("O+",for: .normal)
        }
        let bloodType4 = UIAlertAction(title: "O-", style: .default) { (action) in
            self.getDataWithBloodGroup(bloodtype: "O-")
            self.searchBtnOutlet.setTitle("O-",for: .normal)
        }
        let bloodType5 = UIAlertAction(title: "B+", style: .default) { (action) in
            self.getDataWithBloodGroup(bloodtype: "B+")
            self.searchBtnOutlet.setTitle("B+",for: .normal)
        }
        let bloodType6 = UIAlertAction(title: "B-", style: .default) { (action) in
            self.getDataWithBloodGroup(bloodtype: "B-")
            self.searchBtnOutlet.setTitle("A+",for: .normal)
        }
        let bloodType7 = UIAlertAction(title: "AB+", style: .default) { (action) in
            self.getDataWithBloodGroup(bloodtype: "A+")
            self.getDataWithBloodGroup(bloodtype: "B+")
            self.getDataWithBloodGroup(bloodtype: "AB+")
            self.searchBtnOutlet.setTitle("AB+",for: .normal)
        }
        let bloodType8 = UIAlertAction(title: "AB-", style: .default) { (action) in
            self.getDataWithBloodGroup(bloodtype: "A-")
            self.getDataWithBloodGroup(bloodtype: "B-")
            self.getDataWithBloodGroup(bloodtype: "AB-")
            self.searchBtnOutlet.setTitle("AB-",for: .normal)
        }
        
        actionSheet.addAction(bloodType1)
        actionSheet.addAction(bloodType2)
        actionSheet.addAction(bloodType3)
        actionSheet.addAction(bloodType4)
        actionSheet.addAction(bloodType5)
        actionSheet.addAction(bloodType6)
        actionSheet.addAction(bloodType7)
        actionSheet.addAction(bloodType8)
        
        actionSheet.addAction(cancel)
        
        present(actionSheet, animated: true, completion: nil)
    }
    
    
    var uid = Auth.auth().currentUser?.uid
    var sharedRef = UIApplication.shared.delegate as! AppDelegate
    //var dictData = [String:Any]()
    var donorData : [Donor] = []
    var donorObject : Donor?
    
    var userId = ""
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
    var image = #imageLiteral(resourceName: "icons8-user-40")
    var imageURL = "NA"
//    var tmpUser:User?
//    var currentUser = [User]()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        configureTableView()
        getData()
        donorTableView.reloadData()
     //  donor = createArray()
        donorTableView.delegate = self
        donorTableView.dataSource = self
    }
    
    
    
    public func downloadImageFromFirebase(){
        let uid = Auth.auth().currentUser?.uid
        var imageReference : StorageReference{
            return Storage.storage().reference().child("images").child(uid!)
        }
        let filename = "\(uid)-profileImage.jpg"
        
        let downloadImageRef = imageReference.child(filename)
        
       
        let downloadTask = downloadImageRef.getData(maxSize: 1024 * 1024 * 12) { (data, error) in
            if let imageData = data{
                self.image = UIImage(data: imageData)!
               // self.UserImageView.image = image
                
            }
            print(error ?? "No Error")
        }
        downloadTask.resume()
        
    }
    
    
    func configureTableView()  {
        donorTableView.rowHeight = 90.0
        donorTableView.estimatedRowHeight = 120.0
    }
    
    
    
    func getData() {
        let userRef = self.sharedRef.database.collection("Users").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                
                for document in querySnapshot!.documents {
                    print("\(document.documentID) => \(document.data())")
                    var dataDescription = document.data()
                    self.userId = dataDescription["userId"] as! String
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
                    self.imageURL = (dataDescription["imageUrl"] as? String)!
                    
                    
                  // self.downloadImageFromFirebase()
                    
                    self.donorObject = Donor(userID: self.userId, name: self.name, email: self.email, dob: self.dob, contact: self.contact, bloodtype: self.bloodtype, gender: self.gender, dateOfLastDonation: self.dateOfLastDonation, disease: self.disease, hemoglobinLevel: self.hemoglobinLevel, weight: self.weight, imageURL: self.imageURL )
                    self.donorData.append(self.donorObject!)
                    // Initialize the Array
                    
                    
                    // Remove/filter item with value 'two'
                    
                    self.donorData = self.donorData.filter { $0.userID != self.uid }
                   // print(a)
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
            destVC.hidesBottomBarWhenPushed = true
            
            
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
        let url = URL(string: self.donorData[indexPath.row].imageURL )

        cell.DonorImageView.sd_setImage(with: url as! URL, placeholderImage: self.image)
      
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let donor = self.donorData[indexPath.row]
        performSegue(withIdentifier: "toDonorProfile", sender: donor)
    }


}

