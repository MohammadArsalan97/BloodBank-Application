//
//  RequestsViewController.swift
//  BloodBankApplication
//
//  Created by Mohammad Arsalan on 04/03/2019.
//  Copyright © 2019 Mohammad Arsalan. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class RequestsViewController: UIViewController {

    var bloodReq : [BloodRequest] = []
    
    var uid = Auth.auth().currentUser?.uid
    
   var userImage = #imageLiteral(resourceName: "icons8-user-40")
    
    var reqBloodDict : [String:Any] = [:]
    
    
    var sharedRef = UIApplication.shared.delegate as! AppDelegate
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
       // getData()
        retrieveMessages()
        bloodRequestTableView.delegate = self
        bloodRequestTableView.dataSource = self

    }
    
    
   

    @IBOutlet weak var bloodRequestTableView: UITableView!
    
    func configureTableView()  {
        bloodRequestTableView.rowHeight = 80.0
        bloodRequestTableView.estimatedRowHeight = 120.0
    }
    
    func retrieveMessages() {
        let messageDB = self.sharedRef.database.collection("RequestBlood").addSnapshotListener { querySnapshot, error in
            guard let snapshot = querySnapshot else {
                print("Error fetching snapshots: \(error!)")
                return
            }
            
            snapshot.documentChanges.forEach { diff in
                if (diff.type == .added) {
                    var reqBloodUid = diff.document.documentID
                    self.reqBloodDict = diff.document.data()
                    print("*************-------------**************")
                    print(self.reqBloodDict)
                    let name = self.reqBloodDict["name"] as! String
                    let gender = self.reqBloodDict["gender"] as! String
                    let bloodtype = self.reqBloodDict["bloodtype"] as! String
                    let contact = self.reqBloodDict["contact"] as! String
                    let date = self.reqBloodDict["date"] as! String
                    let location = self.reqBloodDict["location"] as! String
                    let request1 = BloodRequest(name: name, gender: gender, bloodtype: bloodtype, contact: contact, date: date, location: location)
                    self.bloodReq.append(request1)
                    print(request1)
                    self.bloodRequestTableView.reloadData()
                }
            }
        }
        
    }
    
    func getData() {
        let userRef = self.sharedRef.database.collection("RequestBlood").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                //var myArray : [Any] = []
                for document in querySnapshot!.documents {
                    var reqBloodUid = document.documentID
                     self.reqBloodDict = document.data()
                    print("*************-------------**************")
                    print(self.reqBloodDict)
                    let name = self.reqBloodDict["name"] as! String
                    let gender = self.reqBloodDict["gender"] as! String
                    let bloodtype = self.reqBloodDict["bloodtype"] as! String
                    let contact = self.reqBloodDict["contact"] as! String
                    let date = self.reqBloodDict["date"] as! String
                    let location = self.reqBloodDict["location"] as! String
                    let request1 = BloodRequest(name: name, gender: gender, bloodtype: bloodtype, contact: contact, date: date, location: location)
                    self.bloodReq.append(request1)
                    print(request1)
                    self.bloodRequestTableView.reloadData()
                    //self.bloodReq.append(Array(self.reqBloodDict.values))
                    // myArray.append(Array(self.reqBloodDict.values))
                    //print(reqBloodUid)
                   // print(self.reqBloodDict)
             //       print("\(document.documentID) => \(document.data())")
                    
                    //self.name = myArray[5] as! String
                    
                }
               // print(myArray)
                // print(myArray[0])
               // self.bloodReq.append(self.reqBloodDict["name"] as! BloodRequest)
               
            }
            
        }

        
        
        let donorDict: [String:Any] = [:]
        //            "name": self.name,
        //            "bloodtype": self.bloodtype
        
        
//        self.sharedRef.database.collection("Users").document(uid!).updateData(donorDict)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toRequestProfile" {
            let destVC = segue.destination as! RequestListVC
            destVC.request = sender as! BloodRequest
            destVC.hidesBottomBarWhenPushed = true
            
        }
            
    }
    
}

extension RequestsViewController: UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bloodReq.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "RequestCell") as! RequestCell
        
        cell.bloodRequestNameLbl.text = self.bloodReq[indexPath.row].name
        cell.genderLbl.text = self.bloodReq[indexPath.row].gender
        cell.bloodRequestImageView.image = self.userImage
        
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let requestor = self.bloodReq[indexPath.row]
        performSegue(withIdentifier: "toRequestProfile", sender: requestor)
    }
}
