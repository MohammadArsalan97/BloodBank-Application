//
//  CreateAccountViewController.swift
//  BloodBankApplication
//
//  Created by Mohammad Arsalan on 04/03/2019.
//  Copyright © 2019 Mohammad Arsalan. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase

class CreateAccountViewController: UIViewController {

    private var datePicker : UIDatePicker?
    var sharedRef = UIApplication.shared.delegate as! AppDelegate
    var selectedgender : String?
    var selectedDate : String?
    
    var userArray = [User]()
    

    
    @IBOutlet weak var bloodImageView: UIImageView!
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? EditProfileViewController {
            
//            destination.name = nameTxt.text!
//            destination.email = self.emailTxt.text!
//            destination.gender = selectedgender!
//           destination.dob = selectedDate!
//            destination.uid = (Auth.auth().currentUser?.uid)!
            destination.userArray1 = userArray
            
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addDatePicker()
        tappedGesture()
        
        // setImageInCircle(image: bloodImageView)
        // Do any additional setup after loading the view.
        
    }
    
    
    
    func tappedGesture(){
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.viewTapped(gestureRecognizer:)))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc func viewTapped(gestureRecognizer: UITapGestureRecognizer){
        
        view.endEditing(true)
    }
    func addDatePicker(){
        datePicker = UIDatePicker()
        datePicker?.datePickerMode = .date
        dobTxt.inputView = datePicker
        datePicker?.addTarget(self, action: #selector(self.datechanged(datePicker:)), for: .valueChanged)
    }
    
    @objc func datechanged(datePicker: UIDatePicker){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/YYYY"
        
        //dobTxt.text = dateFormatter.string(from: datePicker.date)
        selectedDate = dateFormatter.string(from: datePicker.date)
        dobTxt.text = selectedDate
        view.endEditing(true)
    }

    
    
    @IBOutlet weak var nameTxt: CustomTextField!
    
    @IBOutlet weak var emailTxt: CustomTextField!
    
    @IBOutlet weak var passwordTxt: CustomTextField!
    
    
    @IBOutlet weak var dobTxt: CustomTextField!
    
    
    @IBOutlet weak var maleBtn: UIButton!
    
    @IBOutlet weak var femaleBtn: UIButton!
    
    
    @IBAction func genderButton(_ sender: UIButton) {
        
        if sender.tag == 1 {
            selectedgender = "Male"
            maleBtn.setImage(UIImage(named: "manSelected"), for: .normal)
            femaleBtn.setImage(UIImage(named: "woman"), for: .normal)
        }
        else if sender.tag == 2 {
            selectedgender = "Female"
            femaleBtn.setImage(UIImage(named: "womanSelected"), for: .normal)
            maleBtn.setImage(UIImage(named: "man"), for: .normal)
        }
        
    }
    
   
    
    
    @IBAction func SignUpButton(_ sender: Any) {
//        guard let email = emailTxt.text, let password = passwordTxt.text, let name = nameTxt.text, let dob = dobTxt.text, let gender = selectedgender else {return}
        
        
        
//        Auth.auth().createUser(withEmail: email, password: password) { result, error in
//            if error == nil && result != nil {
//               let id = result!.user.uid
//                let dict: [String:Any] = [
//                    "name": name,
//                    "dob": dob,
//                    "gender": gender,
//                    "email": email
//                ]
//
//
//                self.sharedRef.database.collection("Users").document(id).setData(dict, completion: { (error) in
//                    if error == nil {
//                        self.performSegue(withIdentifier: "toEditProfile", sender: self)
//
//                    }else
//                    {
//                        Alert.showErrorAlert(on: self, message: (error?.localizedDescription)!)
//                    }
//                })
//            }
//        }
        var tempUser = User(name: nameTxt.text!, email: emailTxt.text!, dob: dobTxt.text!, contact: "123456789", bloodtype: "abc", gender: selectedgender!, dateOfLastDonation: "fgh", disease: "jhk", hemoglobinLevel: "lmn", weight: "uvw",password:passwordTxt.text!)
        
        userArray.append(tempUser)
        
        self.performSegue(withIdentifier: "toEditProfile", sender: self)
    }
    
    @IBAction func AlredyHaveAnAccountButton(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
//    func setImageInCircle(image : UIImageView) {
//        image.layer.borderWidth = 1
//        image.layer.masksToBounds = false
//        //image.layer.borderColor = UIColor.black.cgColor
//        image.layer.cornerRadius = bloodImageView.frame.height/2
//        image.clipsToBounds = true
//    }
    
}

