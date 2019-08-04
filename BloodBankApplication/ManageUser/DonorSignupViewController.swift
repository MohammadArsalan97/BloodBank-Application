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

class DonorSignupViewController: UIViewController {
    
    var sharedRef = UIApplication.shared.delegate as! AppDelegate
    
    let uid = Auth.auth().currentUser?.uid
    
     var selectedDate : String?
    var selectedDisease: String?
    var weight : String?
    var hemoglobinLevel : String?
    var userArray2 = [User]()
    var tempArray1 = [User]()
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        createDiseasePicker()
        createToolbar()
        addDatePicker()
        createToolbarForDatePickerView()
        tempArray1 = userArray2
        

        // Do any additional setup after loading the view.
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
        
        tempArray1.last?.weight = weightInput.text
        tempArray1.last?.hemoglobinLevel = hemoglobinInput.text
        tempArray1.last?.dateOfLastDonation = selectedDate
        tempArray1.last?.disease = selectedDisease
        print(tempArray1)
        
        Auth.auth().createUser(withEmail: tempArray1.last!.email, password: (tempArray1.last?.password)!) { result, error in
                    if error == nil && result != nil {
                       let id = result!.user.uid
                          let dict: [String:Any] = [
                            "name": self.tempArray1.last!.name,
                        "dob": self.tempArray1.last!.dob,
                        "gender": self.tempArray1.last!.gender,
                        "email": self.tempArray1.last!.email,
                        "Contact": self.tempArray1.last!.contact,
                        "bloodtype": self.tempArray1.last!.bloodtype,
                        "weight": self.tempArray1.last!.weight,
                        "hemoglobin Level": self.tempArray1.last!.hemoglobinLevel,
                        "date of last donation": self.tempArray1.last!.dateOfLastDonation,
                        "disease(s)": self.tempArray1.last!.disease
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
    
    
    
    func createDiseasePicker() {
        
        let diseasePicker = UIPickerView()
        diseasePicker.delegate = self as? UIPickerViewDelegate
        
        diseaseInput.inputView = diseasePicker
        
        //Customizations
        // dayPicker.backgroundColor = .black
    }
    func createToolbar() {
        
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        
        //Customizations
        //        toolBar.barTintColor = .black
        //        toolBar.tintColor = .white
        
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(DonorSignupViewController.dismissKeyboard))
        
        toolBar.setItems([doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        diseaseInput.inputAccessoryView = toolBar
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    // start datepicker
    
    private var datePicker : UIDatePicker?
   
    func addDatePicker(){
        datePicker = UIDatePicker()
        datePicker?.datePickerMode = .date
        lastDonationDateInput.inputView = datePicker
        datePicker?.addTarget(self, action: #selector(self.datechanged(datePicker:)), for: .valueChanged)
    }
    
    @objc func datechanged(datePicker: UIDatePicker){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/YYYY"
        
        //dobTxt.text = dateFormatter.string(from: datePicker.date)
        selectedDate = dateFormatter.string(from: datePicker.date)
        lastDonationDateInput.text = selectedDate
        view.endEditing(true)
    }
    
    func createToolbarForDatePickerView() {
        
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        
        //Customizations
        //        toolBar.barTintColor = .black
        //        toolBar.tintColor = .white
        
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(DonorSignupViewController.dismissKeyboard))
        
        toolBar.setItems([doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
       lastDonationDateInput.inputAccessoryView = toolBar
    }
    
//    @objc func dismissKeyboard() {
//        view.endEditing(true)
//    }
    
    
    
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
