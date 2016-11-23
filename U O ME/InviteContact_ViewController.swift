//
//  InviteContact_ViewController.swift
//  U O ME
//
//  Created by Collin Walther on 11/8/16.
//  Copyright © 2016 Collin Walther, Rohit Saigal. All rights reserved.
//

import UIKit
import Contacts
import MessageUI

class InviteContact_ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, MFMessageComposeViewControllerDelegate, NavigationMenu_ViewControllerDelegate {

    @IBOutlet var wholeView: UIView!
    @IBOutlet weak var contactTableView: UITableView!
    
    var contactsData = [CNContact]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        self.getContacts()
        addNavigationMenu()
    }
    



    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    
    // Used https://code.tutsplus.com/tutorials/ios-9-an-introduction-to-the-contacts-framework--cms-25599
    func getContacts() {
        let store = CNContactStore()
        
        if CNContactStore.authorizationStatus(for: .contacts) == .notDetermined {
            store.requestAccess(for: .contacts, completionHandler: { (authorized: Bool, error: Error?) -> Void in
                if authorized {
                    self.retrieveContactsWithStore(store)
                }
            })
        } else if CNContactStore.authorizationStatus(for: .contacts) == .authorized {
            self.retrieveContactsWithStore(store)
        }
    }
    
    
    // Used https://code.tutsplus.com/tutorials/ios-9-an-introduction-to-the-contacts-framework--cms-25599
    func retrieveContactsWithStore(_ store: CNContactStore) {
 
        let request = CNContactFetchRequest(keysToFetch: [CNContactIdentifierKey as CNKeyDescriptor, CNContactFormatter.descriptorForRequiredKeys(for: .fullName), CNContactPhoneNumbersKey as CNKeyDescriptor as CNKeyDescriptor])
        
        request.sortOrder = CNContactSortOrder.givenName
        
        do {
            try store.enumerateContacts(with: request) { contact, stop in
                self.contactsData.append(contact)
            }
        } catch {
            print(error)
        }
        DispatchQueue.main.async(execute: { () -> Void in
            self.contactTableView.reloadData()
        })

    }
    
    
    
    
    
    
    // MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("NUMROWS: ", self.contactsData
            .count)
        return self.contactsData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        contactTableView.register(UINib(nibName: "Contact_TableViewCell", bundle: nil), forCellReuseIdentifier: "ContactCell")
        
        
        let cell = contactTableView.dequeueReusableCell(withIdentifier: "ContactCell", for: indexPath) as! Contact_TableViewCell
        let contact = self.contactsData[indexPath.row]
        let formatter = CNContactFormatter()
        formatter.style = .fullName
        
        cell.nameLabel.text = formatter.string(from: contact)
        
        if (contact.isKeyAvailable(CNContactPhoneNumbersKey)) {
            //for phoneNumber:CNLabeledValue in contact.phoneNumbers {
            if contact.phoneNumbers.count > 0{
            let phoneNumber:CNLabeledValue = contact.phoneNumbers[0]
                let a = phoneNumber.value 
                cell.phoneLabel.text = a.stringValue
            }
        }
        

        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let contact = self.contactsData[indexPath.row]
        
        let phoneNumber:CNLabeledValue = contact.phoneNumbers[0]
        let a = phoneNumber.value 
        let number = a.stringValue
        sendTextMessage(number)
        
    }
    

    
    
    
    // This code is taken from the link below.
    // Why reinvent the wheel?
    // https://www.andrewcbancroft.com/2014/10/28/send-text-message-in-app-using-mfmessagecomposeviewcontroller-with-swift/
    func sendTextMessage(_ num: String) {
        
        // Make sure the device can send text messages
        if (canSendText()) {
            let messageComposeVC = MFMessageComposeViewController()
            messageComposeVC.messageComposeDelegate = self
            messageComposeVC.recipients = [num]
            messageComposeVC.body = "Do your friends owe you one? Download U O ME!"
            present(messageComposeVC, animated: true, completion: nil)
            
        } else {
            // Let the user know if his/her device isn't able to send text messages
            let errorAlert = UIAlertView(title: "Cannot Send Text Message", message: "Your device is not able to send text messages.", delegate: self, cancelButtonTitle: "OK")
            errorAlert.show()
        }
        
        
        
    }
    
    func canSendText() -> Bool {
        return MFMessageComposeViewController.canSendText()
    }
    
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        
        print("FinishWithResult Called")
        
        switch result {
        case MessageComposeResult.cancelled :
            print("message canceled")
            
        case MessageComposeResult.failed :
            print("message failed")
            
        case MessageComposeResult.sent :
            print("message sent")
        }
        
        
        controller.dismiss(animated: true, completion: nil)
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    // MARK: Navigation Menu
    
    @IBAction func navigationClick(_ sender: AnyObject) {
        
        if (self.wholeView.frame.origin.x == 0){
            showNavigationMenu()
        }
        else{
            hideNavigationMenu()
        }
    }
    
    
    func addNavigationMenu() {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "NavigationMenuViewController")
        self.view.insertSubview(controller.view, at: 0)
        
        addChildViewController(controller)
        controller.didMove(toParentViewController: self)
     
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture))
        swipeRight.direction = UISwipeGestureRecognizerDirection.right
        self.view.addGestureRecognizer(swipeRight)
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture))
        swipeLeft.direction = UISwipeGestureRecognizerDirection.left
        self.view.addGestureRecognizer(swipeLeft)
    }
    
    func showNavigationMenu() {
        UIView.animate(withDuration: 0.35, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: UIViewAnimationOptions(), animations: { self.wholeView.frame.origin.x = 250}, completion: nil)
        
    }
    
    func hideNavigationMenu() {
        UIView.animate(withDuration: 0.25, animations: {
            self.wholeView.frame.origin.x = 0
            
        })
    }
    
    func respondToSwipeGesture(gesture: UIGestureRecognizer) {
        
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            switch swipeGesture.direction {
            case UISwipeGestureRecognizerDirection.right:
                if (self.wholeView.frame.origin.x == 0){
                    showNavigationMenu()
                }
            case UISwipeGestureRecognizerDirection.left:
                if (self.wholeView.frame.origin.x != 0){
                    hideNavigationMenu()
                }
                
            default:
                break
            }
        }
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
