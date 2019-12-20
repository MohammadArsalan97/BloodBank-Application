//
//  BloodRequestViewController.swift
//  BloodBankApplication
//
//  Created by Mohammad Arsalan on 04/03/2019.
//  Copyright © 2019 Mohammad Arsalan. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class BloodRequestViewController: UIViewController {
 
    var sharedRef = UIApplication.shared.delegate as! AppDelegate
    let uid = Auth.auth().currentUser?.uid
//    var reqName = ""
//    var reqBloodtype = ""
//    var reqDate = ""
//    var reqContact = ""
//    var reqLocation = ""
//    var reqGender = ""
   // var dictData = [String:Any]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        showDatePicker()
        createBloodPicker()
        createToolbar()
        // Do any additional setup after loading the view.
    }
    //-------------------------------************************---------------------------
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
        date.inputAccessoryView = toolbar
        date.inputView = datePicker
        
    }
    
    @objc func donedatePicker(){
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        date.text = formatter.string(from: datePicker.date)
        self.view.endEditing(true)
    }
    
    @objc func cancelDatePicker(){
        self.view.endEditing(true)
    }
//-------------------------------************************---------------------------
    
    
    var bloodType = ["A+",
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
        
        bloodtype.inputView = bloodPicker
        
        //Customizations
        // dayPicker.backgroundColor = .black
    }
    
    func createToolbar() {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        
        //Customizations
        toolBar.barTintColor = .black
        toolBar.tintColor = .white
        
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(dismissKeyboard))
        
        
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(dismissKeyboard));
        
        toolBar.setItems([doneButton,spaceButton,cancelButton], animated: false)
        //toolBar.isUserInteractionEnabled = true
        
        bloodtype.inputAccessoryView = toolBar
    }
    
    
    @objc func dismissKeyboard() {
        self.view.endEditing(true)
    }
    
    
    @IBOutlet weak var bloodtype: CustomTextField!
    @IBOutlet weak var date: CustomTextField!
    
    @IBOutlet weak var contact: CustomTextField!
    
    @IBOutlet weak var location: CustomTextField!
    
    @IBOutlet weak var name: CustomTextField!
    
    @IBOutlet weak var gender: CustomTextField!
    
    @IBAction func submitBtn(_ sender: Any) {
        
        guard let reqName = name.text,let reqBloodtype = bloodtype.text, let reqDate = date.text, let reqContact = contact.text, let reqLocation = location.text, let reqGender = gender.text, let uid = self.uid else {
            return
            
        }
            
           let dict : [String:Any] = [
            
            "name" : reqName,
            "bloodtype" : reqBloodtype,
            "date" : reqDate,
            "contact" : reqContact,
            "location" : reqLocation,
            "gender" : reqGender,
            "uid" : uid
            ]
        
        self.sharedRef.database.collection("RequestBlood").addDocument(data: dict) { (error) in
            if error == nil{
                print("data save")
                self.name.text = ""
                self.bloodtype.text = ""
                self.date.text = ""
                self.contact.text = ""
                self.location.text = ""
                self.gender.text = ""
                
            }else{
                print("error",error)
            }
        }
        
        }
        
        
    
    }

extension BloodRequestViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return bloodType.count
    }
    
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return bloodType[row]
    }
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
       let selectedBloodType = bloodType[row]
        bloodtype.text = selectedBloodType
    }
}
