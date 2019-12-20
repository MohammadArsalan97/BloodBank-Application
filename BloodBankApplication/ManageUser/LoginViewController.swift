//
//  LoginViewController.swift
//  BloodBankApplication
//
//  Created by Mohammad Arsalan on 04/03/2019.
//  Copyright © 2019 Mohammad Arsalan. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        checkUserStatus()
        self.EmailTxt.text = "test2@gmail.com"
        self.PasswordTxt.text = "123456789"
        self.navigationController?.navigationBar.isHidden = true
        //navigationController?.navigationBar.barTintColor = UIColor.red
        // Do any additional setup after loading the view.
      //  setImageInCircle(image: bloodImageView)
        
    }
    func checkUserStatus() {
        if Auth.auth().currentUser != nil {
            // User is signed in.
            // ...
            self.performSegue(withIdentifier: "tabBarSegue", sender: self)
            
            } else {
                // No user is signed in.
                // ... toLogin
                //self.performSegue(withIdentifier: "toLogin", sender: nil)
                
            }
    }
    
    
    
    @IBOutlet weak var bloodImageView: UIImageView!
    
    @IBOutlet weak var EmailTxt: UITextField!
    
    @IBOutlet weak var PasswordTxt: UITextField!
    
    @IBAction func LogInButton(_ sender: Any) {
        
        Auth.auth().signIn(withEmail: EmailTxt.text!, password: PasswordTxt.text!) { (user, error) in
            if user != nil{
//                let vc = self.storyboard?.instantiateViewController(withIdentifier: "toTabBarController") as! HomeViewController
//                self.present(vc, animated: true, completion: nil)
                self.performSegue(withIdentifier: "tabBarSegue", sender: self)
                self.EmailTxt.text = ""
                self.PasswordTxt.text = ""
            }else{
               // print(error?.localizedDescription)
                Alert.showErrorAlert(on: self, message: (error?.localizedDescription)!)
            }
        }
    }
    
    @IBAction func signUpButton(_ sender: Any) {
    }
    
    @IBAction func forgotPasswordButton(_ sender: Any) {
    }
    
//    func setImageInCircle(image : UIImageView) {
//        image.layer.borderWidth = 0
//        image.layer.masksToBounds = false
//        //image.layer.borderColor = UIColor.black.cgColor
//        image.layer.cornerRadius = image.frame.height/2
//        image.clipsToBounds = true
//    }
}
