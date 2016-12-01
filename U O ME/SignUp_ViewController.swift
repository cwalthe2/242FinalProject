//
//  SignUp_ViewController.swift
//  U O ME
//
//  Created by Collin Walther on 11/2/16.
//  Copyright © 2016 Collin Walther, Rohit Saigal. All rights reserved.
//

import UIKit

class SignUp_ViewController: UIViewController {
    
    let MyKeychainWrapper = KeychainWrapper()
    
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    @IBAction func signUpButtonClick(_ sender: AnyObject) {
        var firstNameFilled : Bool = true
        var lastNameFilled : Bool = true
        var emailFilled : Bool = true
        var passwordFilled : Bool = true
        
        
        if (firstName.text == ""){
            firstNameFilled = false
        }
        if (lastName.text == ""){
            lastNameFilled = false
        }
        if (email.text == ""){
            emailFilled = false
        }
        if (password.text == ""){
            passwordFilled = false
        }
        
        if (firstNameFilled && lastNameFilled && emailFilled && passwordFilled){
            UserDefaults.standard.setValue(firstName.text, forKey: "firstName")
            UserDefaults.standard.setValue(lastName.text, forKey: "lastName")
            UserDefaults.standard.setValue(email.text, forKey: "email")

            
            print(password.text)
            MyKeychainWrapper.mySetObject(password.text!, forKey:"v_Data")
            MyKeychainWrapper.writeToKeychain()
            UserDefaults.standard.set(true, forKey: "hasLoginKey")
            UserDefaults.standard.synchronize()
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let controller = storyboard.instantiateViewController(withIdentifier: "News Feed")
            self.present(controller, animated: true, completion: nil)
        }
        else{
            changeTextFieldHintColors(firstNameFilled, lastNameFlag: lastNameFilled, emailFlag: emailFilled, passwordFlag: passwordFilled)
            let errorAlert = UIAlertView(title: "Missing information", message: "Please fill in all of the fields", delegate: self, cancelButtonTitle: "OK")
            errorAlert.show()
        }
        
    }
    
    
    func changeTextFieldHintColors(_ firstNameFlag : Bool, lastNameFlag: Bool, emailFlag: Bool, passwordFlag: Bool){
        
        var pcolor : UIColor = UIColor.gray
        
        if (firstNameFlag == false){
            pcolor = UIColor.red
        }
        firstName.attributedPlaceholder = NSAttributedString(string:"First Name",
                                                                 attributes:[NSForegroundColorAttributeName: pcolor])
        pcolor = UIColor.gray
        if (lastNameFlag == false){
            pcolor = UIColor.red
        }
        lastName.attributedPlaceholder = NSAttributedString(string:"Last Name",
                                                             attributes:[NSForegroundColorAttributeName: pcolor])
        
        pcolor = UIColor.gray
        if (emailFlag == false){
            pcolor = UIColor.red
        }
        email.attributedPlaceholder = NSAttributedString(string:"Email",
                                                             attributes:[NSForegroundColorAttributeName: pcolor])
        
        pcolor = UIColor.gray
        if (passwordFlag == false){
            pcolor = UIColor.red
        }
        password.attributedPlaceholder = NSAttributedString(string:"Password",
                                                             attributes:[NSForegroundColorAttributeName: pcolor])
    }
}
