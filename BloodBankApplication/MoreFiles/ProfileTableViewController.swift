//
//  ProfileTableViewController.swift
//  BloodBankApplication
//
//  Created by Mohammad Arsalan on 10/07/2019.
//  Copyright © 2019 Mohammad Arsalan. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseStorage
import SDWebImage

class ProfileTableViewController: UITableViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    var sharedRef = UIApplication.shared.delegate as! AppDelegate
    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
    
    }
    @IBAction func editPasswordBtn(_ sender: Any) {
        
        Auth.auth().currentUser?.updatePassword(to: changePasswordTxt.text!) { (error) in
            if error != nil{
                Alert.showErrorAlert(on: self, message: (error?.localizedDescription)!)
            }else{
                print("success")
            }
        }
        
    }

//    func alertForChangePassword(){
//        
//        let changePasswordAlert = UIAlertController(title: "Change Password", message: "", preferredStyle: .alert)
//        changePasswordAlert.addTextField { (textfield : UITextField) in
//            textfield.placeholder = "Old Password"
//            }
//        changePasswordAlert.addTextField { (textfield : UITextField) in
//            textfield.placeholder = "New Password"
//        }
//        
//        changePasswordAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
//        changePasswordAlert.addAction(UIAlertAction(title: "Send", style: .default, handler: { (action: UIAlertAction) in
//            <#code#>
//        }))
//        
//        self.present(changePasswordAlert, animated: true, completion: nil)
//    }
    

    func chooseImage(){
    
    let imagePickerController = UIImagePickerController()
    imagePickerController.delegate = self
    
    
    let actionSheet = UIAlertController(title: "Photo Source", message: "Choose a source", preferredStyle: .actionSheet)
    
    actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (action : UIAlertAction) in
    
    if UIImagePickerController.isSourceTypeAvailable(.camera) {
    imagePickerController.sourceType = .camera
    self.present(imagePickerController, animated: true, completion: nil)
    }else{
    
    print("Camera not available")
    }
    
    }))
    actionSheet.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: { (action : UIAlertAction) in
    imagePickerController.sourceType = .photoLibrary
    self.present(imagePickerController, animated: true, completion: nil)
    
    
    }))
    
    actionSheet.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
    self.present(actionSheet, animated: true, completion: nil)
    
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let userImage = info["UIImagePickerControllerOriginalImage"] as! UIImage
        userProfileImage.image = userImage
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    
    
    @IBOutlet weak var userProfileImage: CustomImageView!
    
    @IBAction func editImageBtn(_ sender: Any) {
        print("Hello World!")
        chooseImage()
    }
    
    
    @IBOutlet weak var nameTxt: UITextField!
    
    @IBOutlet weak var changePasswordTxt: UITextField!
    @IBOutlet weak var contactNoTxt: UITextField!
    @IBOutlet weak var bloodtypeTxt: UITextField!
    @IBOutlet weak var dateOfLastDonation: UITextField!
    @IBOutlet weak var weightTxt: UITextField!
    
    
    
    //changePasswordTxt.addTarget(self, action: #selector(textChanged(_:)), for: .editingChanged)
    
    
    func getData() {
        let uid = Auth.auth().currentUser?.uid
        let userRef = self.sharedRef.database.collection("Users").document(uid!)
        //let docRef = db.collection("cities").document("SF")
        
        userRef.getDocument { (document, error) in
            if let document = document, document.exists {
                let dataDescription = document.data()//.map(String.init(describing:)) ?? "nil"
                self.nameTxt.text = dataDescription!["name"] as? String
                self.contactNoTxt.text = dataDescription!["Contact"] as? String
                self.bloodtypeTxt.text = dataDescription?["bloodtype"] as? String
                self.dateOfLastDonation.text = dataDescription?["date of last donation"] as? String
                self.weightTxt.text = dataDescription?["weight"] as? String
                
                
                let data = document.data()
                print("Document data: \(dataDescription)")
                print("Document data: \(data)")
            } else {
                print("Document does not exist")
            }
        }

    }
    
    
//    func uploadImageOnFirebase() {
//        let uid = Auth.auth().currentUser?.uid
//        var imageReference : StorageReference{
//            return Storage.storage().reference().child("images").child(uid!)
//        }
//        let filename = "\(uid)-profileImage.jpg"
//        
//        let uploadImageRef = imageReference.child(filename)
//        
//        
//        guard let image = userProfileImage.image else {
//            return
//        }
//        guard let imageData = UIImageJPEGRepresentation(image, 1) else {
//            return
//        }
//        
//        let uploadTask = uploadImageRef.putData(imageData, metadata: nil) { (metadata, error) in
//            
//            if let error = error {
//                print(error)
//            }else{
//                uploadImageRef.downloadURL(completion: { (url, error) in
//                    if error != nil{
//                        print(error)
//                    }else{
//                        let updateDict: [String:Any] = [
//                            "name": self.tempArray1.last!.name,
//                            "dob": self.tempArray1.last!.dob,
//                            "gender": self.tempArray1.last!.gender,
//                            "email": self.tempArray1.last!.email,
//                            "Contact": self.tempArray1.last!.contact,
//                            "bloodtype": self.tempArray1.last!.bloodtype,
//                            "weight": self.tempArray1.last!.weight,
//                            "hemoglobin Level": self.tempArray1.last!.hemoglobinLevel,
//                            "date of last donation": self.tempArray1.last!.dateOfLastDonation,
//                            "disease(s)": self.tempArray1.last!.disease,
//                            "imageUrl" : url?.absoluteString ?? self.userImage
//                        ]
//                        self.sharedRef.database.collection("Users").document(uid!).updateData(updateDict)
//                    }
//                })
//            }
//            
//            
//        }
//        
//        
//        
//        uploadTask.observe(.progress) { (snapshot) in
//            print(snapshot.progress ?? "No more progress")
//        }
//        
//        uploadTask.resume()
//    }
    
    
    
}
