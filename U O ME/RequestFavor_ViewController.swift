//
//  RequestFavor.swift
//  U O ME
//
//  Created by Rohit Saigal on 11/3/16.
//  Copyright © 2016 Collin Walther, Rohit Saigal. All rights reserved.
//

import UIKit


class RequestFavor: UIViewController{
    

    @IBOutlet weak var recipientName: UITextField!
    
    @IBOutlet weak var favorValue: UISlider!

    @IBOutlet weak var displayFavor: UITextView!
    var user:User!
    var friend:User?
    var friends:[User]?
    var value:User!
    override func viewDidLoad() {
        
        super.viewDidLoad()
       
      
        user=value
      
        //friend=(presentingViewController as! UserProfile).friend
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var displaySlider: UILabel!
    @IBAction func request(sender: UIButton) {
        //Pass.passed.added=true
        //if let isadded=Pass.passed.added{
        //    print(isadded)
        //}
    print("button was pressed")
        var valid=false
        
        var recipient:User?
        
            for u in friends!{
                print(u.name)
                switch(u.name.caseInsensitiveCompare(recipientName.text!))
                    
                {
                case .orderedSame:
                    recipient=u
                    valid=true
                    break
                default:
                    break
                }
            }
        
        if(valid==false){
            recipient=User(name: recipientName.text!, level: 0, image: UIImage(named: "default-profile.png")!, points: 0)
        }
        
        
        let newFavor=Favor(value: Int(favorValue.value), recipient: recipient!, favorDescription: displayFavor.text as NSString)
        recipient?.favorHistory.append(newFavor)
        recipient?.pendingFavors.append(newFavor)
        user.requestedFavors.append(newFavor)
        user?.favorHistory.append(newFavor)
        
        
        /*
        let controller = self.storyboard!.instantiateViewControllerWithIdentifier("User Profile")
        self.presentViewController(controller,animated:true,completion:nil)
    */
    }
    
    @IBAction func sliderAction(sender: AnyObject) {
        
        displaySlider.text=String(Int(favorValue.value))
    }
    func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "toProfile"){
            let userProfile = (segue.destination as! UserProfile)
            userProfile.value = user
            
        }
    }




}
