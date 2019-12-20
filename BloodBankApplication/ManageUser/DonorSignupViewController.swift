//
//  DonorSignupViewController.swift
//  BloodBankApplication
//
//  Created by Mohammad Arsalan on 18/04/2019.
//  Copyright © 2019 Mohammad Arsalan. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseStorage


class DonorSignupViewController: UIViewController {
    
    var sharedRef = UIApplication.shared.delegate as! AppDelegate
    
    
    
     var selectedDate : String?
    var selectedDisease: String?
    var weight : String?
    var hemoglobinLevel : String?
    var userArray2 = [User]()
    var tempArray1 = [User]()
    var userImage = #imageLiteral(resourceName: "icons8-user-40")
    
    
    @IBOutlet weak var UserImageView: CustomImageView!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
       // downloadImageFromFirebase()
        
        createDiseasePicker()
        createToolbar()
        showDatePicker()
//        addDatePicker()
//        createToolbarForDatePickerView()
        tempArray1 = userArray2
        UserImageView.image = userImage
        

        // Do any additional setup after loading the view.
    }
    
    
    
        func downloadImageFromFirebase(){
            let uid = Auth.auth().currentUser?.uid
            var imageReference : StorageReference{
                return Storage.storage().reference().child("images").child(uid!)
            }
            let filename = "\(uid)-profileImage.jpg"
            
            let downloadImageRef = imageReference.child(filename)
    
            let downloadTask = downloadImageRef.getData(maxSize: 1024 * 1024 * 12) { (data, error) in
                if let imageData = data{
                    let image = UIImage(data: imageData)
                    self.UserImageView.image = image
                }
                print(error ?? "No Error")
            }

            downloadTask.resume()
        }
    
    
    
    
     // initialize variable
    
    let disease = ["Hepatitis B",
                   "Hepatitis C",
                   "anti-HIV 1 and 2 and HIV NAT",
                   "anti-HTLV I and II",
                   "Syphilis",
                   "Malarial antibodies",
                   "West Nile Virus antibodies",
                   "Trypanosoma cruzi antibodies"]

    
    
    @IBOutlet weak var hemoglobinInput: CustomTextField!
    
    @IBOutlet weak var weightInput: CustomTextField!
    @IBOutlet weak var lastDonationDateInput: CustomTextField!
    
    
    @IBOutlet weak var diseaseInput: CustomTextField!
    
    
    
    @IBAction func doneBtn(_ sender: Any) {
        
        if (weightInput.text?.isEmpty)! || (hemoglobinInput.text?.isEmpty)! || (lastDonationDateInput.text?.isEmpty)! || (diseaseInput.text?.isEmpty)!{
            
            Alert.showIncompleteFormAlert(on: self)
        }else{
        tempArray1.last?.weight = weightInput.text
        tempArray1.last?.hemoglobinLevel = hemoglobinInput.text
        tempArray1.last?.dateOfLastDonation = selectedDate
        tempArray1.last?.disease = selectedDisease
        print(tempArray1)
       
        
        
        
        Auth.auth().createUser(withEmail: tempArray1.last!.email, password: (tempArray1.last?.password)!) { result, error in
                    if error == nil && result != nil {
                       let id = result!.user.uid
                        self.tempArray1.last?.userID = id
//                        let dict: [String:Any] = [
//                            "name": self.tempArray1.last!.name,
//                            "dob": self.tempArray1.last!.dob,
//                            "gender": self.tempArray1.last!.gender,
//                            "email": self.tempArray1.last!.email,
//                            "Contact": self.tempArray1.last!.contact,
//                            "bloodtype": self.tempArray1.last!.bloodtype,
//                            "weight": self.tempArray1.last!.weight,
//                            "hemoglobin Level": self.tempArray1.last!.hemoglobinLevel,
//                            "date of last donation": self.tempArray1.last!.dateOfLastDonation,
//                            "disease(s)": self.tempArray1.last!.disease
//                            //"imageUrl" : self.imageURL
//                        ]
                        
//                        self.sharedRef.database.collection("Users").document(id).setData(dict, completion: { (error) in
//                            if error == nil {
//                                self.performSegue(withIdentifier: "tabBarSegue", sender: self)
//
//                            }else
//                            {
//                                Alert.showErrorAlert(on: self, message: (error?.localizedDescription)!)
//                            }
//                        })
                        
                        self.uploadImageOnFirebase()
                        
                        
                        
                        
                    }else{
                      print(error?.localizedDescription )
                        Alert.showErrorAlert(on: self, message: (error?.localizedDescription)!)
            }
            
                }
            
        
        
//        guard weight == weightInput.text, hemoglobinLevel == hemoglobinInput.text else {
//            return
//        }
//        self.sharedRef.database.collection("Users").document(uid!).updateData(dict) { (err) in
//            if err == nil {
//                self.performSegue(withIdentifier: "tabBarSegue", sender: self)
////                let vc = self.storyboard?.instantiateViewController(withIdentifier: "toTabBarController") as! HomeViewController
////                self.present(vc, animated: true, completion: nil)
//            }
//            else{
//                Alert.showErrorAlert(on: self, message: (err?.localizedDescription)!)
//            }
//        }
        

        
        }
        
        
    }
    
    func uploadImageOnFirebase() {
        
        let uid = Auth.auth().currentUser?.uid
        var imageReference : StorageReference{
            return Storage.storage().reference().child("images").child(uid!)
        }
        let filename = "\(uid)-profileImage.jpg"
        
        let uploadImageRef = imageReference.child(filename)
        
        
        guard let image = UserImageView.image else {
            return
        }
        guard let imageData = UIImageJPEGRepresentation(image, 0.75) else {
            return
        }
        
        let uploadTask = uploadImageRef.putData(imageData, metadata: nil) { (metadata, error) in
            
            if let error = error {
                print(error.localizedDescription)
            }else{
                
                uploadImageRef.downloadURL(completion: { (url, error) in
                    if error != nil{
                        print(error)
                    }else{
                        let dict: [String:Any] = [
                            "userId": self.tempArray1.last!.userID,
                            "name": self.tempArray1.last!.name,
                            "dob": self.tempArray1.last!.dob,
                            "gender": self.tempArray1.last!.gender,
                            "email": self.tempArray1.last!.email,
                            "Contact": self.tempArray1.last!.contact,
                            "bloodtype": self.tempArray1.last!.bloodtype,
                            "weight": self.tempArray1.last!.weight,
                            "hemoglobin Level": self.tempArray1.last!.hemoglobinLevel,
                            "date of last donation": self.tempArray1.last!.dateOfLastDonation,
                            "disease(s)": self.tempArray1.last!.disease,
                            "imageUrl" : url?.absoluteString
                        ]
                        //print(updateDict["imageUrl"])
                        self.sharedRef.database.collection("Users").document(uid!).setData(dict, completion: { (error) in
                            if error == nil {
                                self.performSegue(withIdentifier: "tabBarSegue", sender: self)

                            }else
                            {
                                Alert.showErrorAlert(on: self, message: (error?.localizedDescription)!)
                            }
                        })
                      //  self.sharedRef.database.collection("Users").document(uid!).updateData(updateDict)
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
    
    
    
    
    
    
    func createDiseasePicker() {
        
        let diseasePicker = UIPickerView()
        diseasePicker.delegate = self as? UIPickerViewDelegate
        
        diseaseInput.inputView = diseasePicker
        
        //Customizations
        // dayPicker.backgroundColor = .black
        //diseasePicker.backgroundColor = .black
        //diseasePicker.tintColor = .white
    }
    func createToolbar() {
        
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        
        //Customizations
        toolBar.barTintColor = .black
        toolBar.tintColor = .white
        
        
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(DonorSignupViewController.dismissKeyboard))
        
        toolBar.setItems([doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        diseaseInput.inputAccessoryView = toolBar
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    // start datepicker
    
    let datePicker = UIDatePicker()
    
    func showDatePicker(){
        //Formate Date
        datePicker.datePickerMode = .date
        
        //ToolBar
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(donedatePicker));
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelDatePicker));
        
        toolbar.setItems([doneButton,spaceButton,cancelButton], animated: false)
        
        //Customizations
        toolbar.barTintColor = .black
        toolbar.tintColor = .white
        lastDonationDateInput.inputAccessoryView = toolbar
        lastDonationDateInput.inputView = datePicker
        
    }
    
    @objc func donedatePicker(){
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        lastDonationDateInput.text = formatter.string(from: datePicker.date)
        selectedDate = lastDonationDateInput.text
        self.view.endEditing(true)
    }
    
    @objc func cancelDatePicker(){
        self.view.endEditing(true)
    }
    
    
    
    
}

extension DonorSignupViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return disease.count
    }
    
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return disease[row]
    }
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedDisease = disease[row]
        diseaseInput.text = selectedDisease
    }
}
