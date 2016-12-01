//
//  NavigationMenu_ViewController.swift
//  U O ME
//
//  Created by Collin Walther on 11/3/16.
//  Copyright © 2016 Collin Walther, Rohit Saigal. All rights reserved.
//

import UIKit

@objc
protocol NavigationMenu_ViewControllerDelegate {
    func addNavigationMenu()
    func showNavigationMenu()
    func hideNavigationMenu()
}

class NavigationMenu_ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var usernameButton: UIButton!
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var navigationTableView: UITableView!
    
    struct menuItem {
        var img = UIImage()
        var name = String()
    }
    
    var menuItems: Array<menuItem>!
    
    override func viewDidLoad() {
        super.viewDidLoad()

       print("Loading nav menu")
        var firstName : String = UserDefaults.standard.value(forKey: "firstName") as! String
        firstName = firstName + " "
        
        let lastName : String = UserDefaults.standard.value(forKey: "lastName") as! String
        let fullName : String = firstName + lastName
        usernameButton.setTitle(fullName, for: UIControlState())
        loadProPic()
        
        navigationTableView.register(UINib(nibName: "MenuItem_TableViewCell", bundle: nil), forCellReuseIdentifier: "NavCell")
        configureMenuItems()
        navigationTableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadProPic(){
        if let imageData: NSData = UserDefaults.standard.value(forKey: "proPicData") as? NSData{
        
            let userProfileImage = UIImage(data: imageData as Data)
            self.userImageView.image = userProfileImage
        }
        else{
            
        }
        
    }
    
    func configureMenuItems() {
        menuItems = [
            menuItem(img: UIImage(named: "news_icon 30x30.png")!, name: "News Feed"),
            menuItem(img: UIImage(named: "favor_icon 30x30.png")!, name: "Favor Feed"),
            menuItem(img: UIImage(named: "invite_icon 30x30.png")!, name: "Invite Friends"),
            menuItem(img: UIImage(named: "logout_icon 30x30.png")!, name: "Logout")
            
        ]
        
    }



    // MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = navigationTableView.dequeueReusableCell(withIdentifier: "NavCell", for: indexPath) as! MenuItem_TableViewCell
        
        cell.configureCell(menuItems[indexPath.row])
        return cell
    }
    


// Mark: Table View Delegate

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        print("Clicked menuItem")
        var vc_name = menuItems[indexPath.row].name
        
        if vc_name == "Logout"{
            UserDefaults.standard.setValue("true", forKey: "isLoggingOut")
            UserDefaults.standard.synchronize()
            vc_name = "Main Screen"
        }
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: vc_name)
        //self.present(controller, animated: true, completion: nil)
        
        
        let transition = CATransition()
        transition.duration = 0.2
        transition.type = kCATransitionPush
        transition.subtype = kCATransitionFromRight
        view.window!.layer.add(transition, forKey: kCATransition)
        present(controller, animated: false, completion: nil)
        
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 108
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
}


