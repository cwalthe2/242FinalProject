//
//  ViewController.swift
//  U O ME
//
//  Created by Collin Walther on 11/1/16.
//  Copyright © 2016 Collin Walther, Rohit Saigal. All rights reserved.
//

import UIKit
import FBSDKLoginKit

class Main_ViewController: UIViewController, FBSDKLoginButtonDelegate {
    
    let MyKeychainWrapper = KeychainWrapper()

    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var propicImageView: UIImageView!
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        
        
        if let storedUsername = UserDefaults.standard.value(forKey: "email") as? String {
            usernameField.text = storedUsername as String
        }
        
        let fbLoginButton = FBSDKLoginButton()
        fbLoginButton.readPermissions = ["email", "public_profile"]
        self.view.addSubview(fbLoginButton)
        fbLoginButton.frame = CGRect(x: 79, y: 423, width: 162, height: 30)
        
        fbLoginButton.delegate = self
        
        if let isLoggingOut = UserDefaults.standard.value(forKey: "isLoggingOut") as? String {
            if isLoggingOut == "true"{
                let loginManager = FBSDKLoginManager()
                loginManager.logOut()
                UserDefaults.standard.setValue("false", forKey: "isLoggingOut")
                UserDefaults.standard.synchronize()

            }
        }
        
         else if let token = FBSDKAccessToken.current() {
            print("Already logged in to facebook")
            performSegue(withIdentifier: "newsFeed", sender: self)
        }
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        print("Did logout of facebook")
    }
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        if error != nil{
            print(error)
            return
        }
        
        print("Successful facebook login")
        fetchProfile()
        print("Loaded profile")
        
    }
    
    func fetchProfile() {
        print("Fetching profile")
        
        let parameters = ["fields": "email, first_name, last_name, picture.type(large)"]
        FBSDKGraphRequest(graphPath: "me", parameters: parameters)
            .start(completionHandler:  { (connection, result, error) in
                    let result = result as? NSDictionary
                    let email = result?["email"] as? String
                    let first_name = result?["first_name"] as? String
                    let last_name = result?["last_name"] as? String
             
                
                print(email ?? "no email")
                print(first_name ?? "no first name")
                print(last_name ?? "no last name")
                
                
                if let profilePictureObj = result?.value(forKey: "picture") as? NSDictionary
                {
                    let data = profilePictureObj.value(forKey: "data") as! NSDictionary
                    let pictureUrlString  = data.value(forKey: "url") as! String
                    let pictureUrl = NSURL(string: pictureUrlString)
                    

                        
                    let imageData = NSData(contentsOf: pictureUrl! as URL)
                    UserDefaults.standard.setValue(imageData, forKey: "proPicData")

                    
                    
                }
                
                UserDefaults.standard.setValue(first_name, forKey: "firstName")
                UserDefaults.standard.setValue(last_name, forKey: "lastName")
                UserDefaults.standard.setValue(email, forKey: "email")
                
                UserDefaults.standard.synchronize()
                print("Added info to NSUser Defaults")
                self.performSegue(withIdentifier: "newsFeed", sender: self)
            })
    }

    



    
    
    
    @IBAction func loginAction(_ sender: AnyObject) {
        
        if (usernameField.text == "" || passwordField.text == "") {
            let alertView = UIAlertController(title: "Login Problem",
                                              message: "Wrong username or password." as String, preferredStyle:.alert)
            let okAction = UIAlertAction(title: "Try again", style: .default, handler: nil)
            alertView.addAction(okAction)
            self.present(alertView, animated: true, completion: nil)
            return;
        }
        
        usernameField.resignFirstResponder()
        passwordField.resignFirstResponder()
        
        
            if checkLogin(usernameField.text!, password: passwordField.text!) {
                performSegue(withIdentifier: "newsFeed", sender: self)
            } else {
                // 7.
                let alertView = UIAlertController(title: "Login Problem",
                                                  message: "Wrong username or password." as String, preferredStyle:.alert)
                let okAction = UIAlertAction(title: "Try again", style: .default, handler: nil)
                alertView.addAction(okAction)
                self.present(alertView, animated: true, completion: nil)
            }
        
        
    }
    
    
    func checkLogin(_ username: String, password: String ) -> Bool {

        if password == MyKeychainWrapper.myObject(forKey: "v_Data") as! String &&
            username == UserDefaults.standard.value(forKey: "email") as? String {
            print("Success login!")
            return true
        } else {
            return false
        }
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if (textField == usernameField){
            usernameField.endEditing(true)
            passwordField.becomeFirstResponder()
        }
        else{
            passwordField.endEditing(true)
            loginAction(loginButton)
        }
        

        return false
    }
    
    

}

