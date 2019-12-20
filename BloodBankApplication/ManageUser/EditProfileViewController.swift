//
//  EditProfileViewController.swift
//  BloodBankApplication
//
//  Created by Mohammad Arsalan on 18/04/2019.
//  Copyright © 2019 Mohammad Arsalan. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseStorage

class EditProfileViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    @IBOutlet weak var SwitchBtnOutlet: UISwitch!
    
    @IBOutlet weak var NameTxt: CustomTextField!
    
    @IBOutlet weak var emailTxt: CustomTextField!
    
    @IBOutlet weak var contactNoTxt: CustomTextField!
    
    @IBOutlet weak var bloodTypeTxt: CustomTextField!
    
    @IBOutlet weak var genderLbl: UILabel!
    
    @IBOutlet weak var dobLbl: UILabel!
    
    @IBOutlet weak var userImageView: UIImageView!
    
    var switchButton = false
    var userArray1 = [User]()
    var tempArray = [User]()
    
    var sharedRef = UIApplication.shared.delegate as! AppDelegate

    var name = ""
    var email = ""
    var gender = ""
    var dob = ""
    var userImage = #imageLiteral(resourceName: "icons8-user-40")
    
    
 

    override func viewDidLoad() {
        super.viewDidLoad()
        
        userImageView.image = userImage
        
        tempArray = userArray1
        
        NameTxt.text = tempArray.last?.name
        emailTxt.text = tempArray.last?.email
        genderLbl.text = tempArray.last?.gender
        dobLbl.text = tempArray.last?.dob
        createBloodPicker()
        createToolbar()
     
        SwitchBtnOutlet.isOn = false

        // Do any additional setup after loading the view.
    }
    
   
    

      
    

    
    

    

    // ------------------upload Image to firebase storage-----------------------
    
//    func uploadProfileImage(imageData: Data)
//    {
//        let activityIndicator = UIActivityIndicatorView.init(activityIndicatorStyle: .gray)
//        activityIndicator.startAnimating()
//        activityIndicator.center = self.view.center
//        self.view.addSubview(activityIndicator)
//
//
//        let storageReference = Storage.storage().reference()
//        //let currentUser = Auth.auth().currentUser
//       let profileImageRef = storageReference.child("images")
//        //.child(currentUser!.uid).child("(currentUser!.uid)-profileImage.jpg")
//
//        let uploadMetaData = StorageMetadata()
//        uploadMetaData.contentType = "image/jpeg"
//
//        profileImageRef.putData(imageData, metadata: uploadMetaData) { (uploadedImageMeta, error) in
//
//            activityIndicator.stopAnimating()
//            activityIndicator.removeFromSuperview()
//
//            profileImageRef.downloadURL(completion: { (url, error) in
//                print(url)
//            })
//            if error != nil
//            {
//                print("Error took place \(String(describing: error?.localizedDescription))")
//                return
//            } else {
//
//                self.userImageView.image = UIImage(data: imageData)
//
//                print("Meta data of uploaded image \(String(describing: uploadedImageMeta))")
//            }
//        }
//    }
    // END FUNCTION
    
    @IBAction func chooseImage(_ sender: Any) {
        
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
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(actionSheet, animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
       let userImage = info["UIImagePickerControllerOriginalImage"] as! UIImage
        userImageView.image = userImage
        
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    
    
    
    
    
    // uipickerview for blood type
    
    var selectedBloodType: String?

    let bloodtype = ["A+",
                "A-",
                "O+",
                "O-",
                "B+",
                "B-",
                "AB+",
                "AB-"]
    
    func createBloodPicker() {
        
        let bloodPicker = UIPickerView()
        bloodPicker.delegate = self as? UIPickerViewDelegate
        
        bloodTypeTxt.inputView = bloodPicker
        
        //Customizations
        // dayPicker.backgroundColor = .black
    }
    
    func createToolbar() {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        
        //Customizations
        toolBar.barTintColor = .black
        toolBar.tintColor = .white
        
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(EditProfileViewController.dismissKeyboard))
        
        toolBar.setItems([doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        bloodTypeTxt.inputAccessoryView = toolBar
    }
    
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }


    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDonorSignup" {
           let destVC = segue.destination as! DonorSignupViewController
            destVC.userArray2 = tempArray
            destVC.userImage = userImageView.image!
    }
}
    
    // donor Switch Button
    
    @IBAction func donorSwitchBtn(_ sender: UISwitch) {
        
        if sender.isOn {
            switchButton = true
        }
        else{
            switchButton = false
        }
    }
   
  // Continue Button
    
    @IBAction func continueButton(_ sender: Any) {
        if (NameTxt.text?.isEmpty)! || (bloodTypeTxt.text?.isEmpty)! || (contactNoTxt.text?.isEmpty)! {
            Alert.showIncompleteFormAlert(on: self)
        }else{

        
        if tempArray.last?.name == (userArray1.last?.name)!{
            print("same name")
        }else{
            tempArray.last?.name = NameTxt.text!
        }
        
       
       tempArray.last?.bloodtype = bloodTypeTxt.text!
        tempArray.last?.contact = contactNoTxt.text!
      
        
        
        

        if self.switchButton == true{
//                let vc = self.storyboard?.instantiateViewController(withIdentifier: "toDonorSignupVC") as! DonorSignupViewController
//                self.present(vc, animated: true, completion: nil)
                self.performSegue(withIdentifier: "toDonorSignup", sender: self)
            
                
        }else {
                
//                let vc = self.storyboard?.instantiateViewController(withIdentifier: "toTabBarController") as! HomeViewController
//                self.present(vc, animated: true, completion: nil)
 
            Auth.auth().createUser(withEmail: tempArray.last!.email, password: tempArray.last!.password) { result, error in
                if error == nil && result != nil {
                    self.tempArray.last?.userID = (Auth.auth().currentUser?.uid)!
//                    let id = Auth.auth().currentUser?.uid
//                    let dict: [String:Any] = [
//                        "name": self.tempArray.last!.name,
//                        "dob": self.tempArray.last!.dob,
//                        "gender": self.tempArray.last!.gender,
//                        "email": self.tempArray.last!.email,
//                        "Contact": self.tempArray.last!.contact,
//                        "bloodtype": self.tempArray.last!.bloodtype,
//                        "weight": self.tempArray.last!.weight,
//                        "hemoglobin Level": self.tempArray.last!.hemoglobinLevel,
//                        "date of last donation": self.tempArray.last!.dateOfLastDonation,
//                        "disease(s)": self.tempArray.last!.disease
//                    ]
                    
                    
//                    self.sharedRef.database.collection("Users").document(id!).setData(dict, completion: { (error) in
//                        if error == nil {
//                            //self.uploadImageOnFirebase()
//                            self.performSegue(withIdentifier: "tabBarSegue", sender: self)
//
//                        }else
//                        {
//                            Alert.showErrorAlert(on: self, message: (error?.localizedDescription)!)
//                        }
//                    })
                    self.uploadImageOnFirebase()
                    
                }
                    else{
                        Alert.showErrorAlert(on: self, message: (error?.localizedDescription)!)
                    }
            }
                
            }

        }
    }
    func uploadImageOnFirebase() {
        
        let uid = Auth.auth().currentUser?.uid
        var imageReference : StorageReference{
            return Storage.storage().reference().child("images").child(uid!)
        }
        let filename = "\(uid)-profileImage.jpg"

        let uploadImageRef = imageReference.child(filename)


        guard let image = userImageView.image else {
            return
        }
        guard let imageData = UIImageJPEGRepresentation(image, 0.75) else {
            return
        }

        let uploadTask = uploadImageRef.putData(imageData, metadata: nil) { (metadata, error) in

            if let error = error {
                print(error)
            }else{
               
                uploadImageRef.downloadURL(completion: { (url, error) in
                    if error != nil{
                        print(error)
                    }else{
                        let dict: [String:Any] = [
                            "userId":self.tempArray.last?.userID,
                            "name": self.tempArray.last!.name,
                            "dob": self.tempArray.last!.dob,
                            "gender": self.tempArray.last!.gender,
                            "email": self.tempArray.last!.email,
                            "Contact": self.tempArray.last!.contact,
                            "bloodtype": self.tempArray.last!.bloodtype,
                            "weight": self.tempArray.last!.weight,
                            "hemoglobin Level": self.tempArray.last!.hemoglobinLevel,
                            "date of last donation": self.tempArray.last!.dateOfLastDonation,
                            "disease(s)": self.tempArray.last!.disease,
                            "imageUrl" : url?.absoluteString ?? self.userImage
                        ]
                      //  print(updateDict["imageUrl"])
                        self.sharedRef.database.collection("Users").document(uid!).setData(dict, completion: { (error) in
                            if error == nil {
                                //self.uploadImageOnFirebase()
                                self.performSegue(withIdentifier: "tabBarSegue", sender: self)
                                
                            }else
                            {
                                Alert.showErrorAlert(on: self, message: (error?.localizedDescription)!)
                            }
                        })
                        
                       // self.sharedRef.database.collection("Users").document(uid!).updateData(updateDict)
                    }
                })
            }

                        print("Upload Task Finised")
                        print(metadata ?? "No Metadata")
                        print(error ?? "No Error")

        }


        uploadTask.resume()
       // uploadTask.removeAllObservers()
    }
}

    
    
    


extension EditProfileViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return bloodtype.count
    }
    
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return bloodtype[row]
    }
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        selectedBloodType = bloodtype[row]
        bloodTypeTxt.text = selectedBloodType
    }
    
    //        func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
    //
    //            var label: UILabel
    //
    //            if let view = view as? UILabel {
    //                label = view
    //            } else {
    //                label = UILabel()
    //            }
    //
    //            label.textColor = .green
    //            label.textAlignment = .center
    //            label.font = UIFont(name: "Menlo-Regular", size: 17)
    //
    //            label.text = days[row]
    //
    //            return label
    //        }
}


//self.pickerController.delegate = self
//let tapGesture = UITapGestureRecognizer(target: self, action: #selector(EditProfileViewController.handleSelectProfileImage))
//userImageView.addGestureRecognizer(tapGesture)
//userImageView.isUserInteractionEnabled = true
//userImageView.layer.cornerRadius = 25
//userImageView.clipsToBounds = true
//pickerController.allowsEditing = true
//pickerController.mediaTypes = ["public.image", "public.movie"]
//pickerController.sourceType =


