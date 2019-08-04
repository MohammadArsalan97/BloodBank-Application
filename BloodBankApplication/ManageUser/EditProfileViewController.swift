//
//  EditProfileViewController.swift
//  BloodBankApplication
//
//  Created by Mohammad Arsalan on 18/04/2019.
//  Copyright © 2019 Mohammad Arsalan. All rights reserved.
//

import UIKit
import Firebase

class EditProfileViewController: UIViewController {
    

    
    var switchButton = false
    var userArray1 = [User]()
    var tempArray = [User]()
    
    var sharedRef = UIApplication.shared.delegate as! AppDelegate

    var name = ""
    var email = ""
    var gender = ""
    var dob = ""
    var uid = ""
    
   
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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

    @IBOutlet weak var userImageView: UIImageView!
    
    @IBOutlet weak var NameTxt: CustomTextField!
    
    @IBOutlet weak var emailTxt: CustomTextField!
    
    @IBOutlet weak var contactNoTxt: CustomTextField!
    
    @IBOutlet weak var bloodTypeTxt: CustomTextField!
    
    @IBOutlet weak var genderLbl: UILabel!
    
    @IBOutlet weak var dobLbl: UILabel!
    
    @IBOutlet weak var SwitchBtnOutlet: UISwitch!
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
//        toolBar.barTintColor = .black
//        toolBar.tintColor = .white
        
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
        

        
        //tempArray.last?.name = (userArray1.last?.name)!
       // tempArray.last?.email = (userArray1.last?.email)!
        //tempArray.last?.dob = (userArray1.last?.dob)!
       tempArray.last?.bloodtype = bloodTypeTxt.text!
       // tempArray.last?.gender = (userArray1.last?.gender)!
        tempArray.last?.contact = contactNoTxt.text!
       // tempArray.last?.password = (userArray1.last?.password)!
        
        
        
//        guard let contact = contactNoTxt.text, let bloodType = selectedBloodType
//            else {return}
//        let dict: [String:Any] = [
//            "Contact": contact,
//            "bloodtype": bloodType
//        ]
        
//        self.sharedRef.database.collection("Users").document(uid).updateData(dict) { (err) in
//            if err == nil  &&
        if self.switchButton == true{
//                let vc = self.storyboard?.instantiateViewController(withIdentifier: "toDonorSignupVC") as! DonorSignupViewController
//                self.present(vc, animated: true, completion: nil)
                self.performSegue(withIdentifier: "toDonorSignup", sender: self)
                
        }else {
                
//                let vc = self.storyboard?.instantiateViewController(withIdentifier: "toTabBarController") as! HomeViewController
//                self.present(vc, animated: true, completion: nil)
 
            Auth.auth().createUser(withEmail: tempArray.last!.email, password: tempArray.last!.password) { result, error in
                if error == nil && result != nil {
                    let id = result!.user.uid
                    let dict: [String:Any] = [
                        "name": self.tempArray.last!.name,
                        "dob": self.tempArray.last!.dob,
                        "gender": self.tempArray.last!.gender,
                        "email": self.tempArray.last!.email,
                        "Contact": self.tempArray.last!.contact,
                        "bloodtype": self.tempArray.last!.bloodtype,
                        "weight": self.tempArray.last!.weight,
                        "hemoglobin Level": self.tempArray.last!.hemoglobinLevel,
                        "date of last donation": self.tempArray.last!.dateOfLastDonation,
                        "disease(s)": self.tempArray.last!.disease
                    ]
                    
                    
                    self.sharedRef.database.collection("Users").document(id).setData(dict, completion: { (error) in
                        if error == nil {
                            self.performSegue(withIdentifier: "tabBarSegue", sender: self)
                            
                        }else
                        {
                            Alert.showErrorAlert(on: self, message: (error?.localizedDescription)!)
                        }
                    })
                }
                    else{
                        Alert.showErrorAlert(on: self, message: (error?.localizedDescription)!)
                    }
            }
                
            }

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



