//
//  FavorFeed_ViewController.swift
//  U O ME
//
//  Created by Collin Walther on 11/2/16.
//  Copyright © 2016 Collin Walther, Rohit Saigal. All rights reserved.
//

import UIKit

class FavorFeed_ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, NavigationMenu_ViewControllerDelegate {

    @IBOutlet weak var favorTable: UITableView!
    @IBOutlet weak var navButton: UIButton!
    @IBOutlet weak var favorView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        favorTable.registerNib(UINib(nibName: "Favor_TableViewCell", bundle: nil), forCellReuseIdentifier: "FavorCell")
        
        
        addNavigationMenu()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    // MARK: Favor tableview
    func tableView(tableView:UITableView, numberOfRowsInSection section:Int) -> Int
    {
        return 2
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = favorTable.dequeueReusableCellWithIdentifier("FavorCell", forIndexPath: indexPath) as! Favor_TableViewCell
        
        if (indexPath.row == 0){
            cell.topLabel.text = "Collin W. is awarding 4 points for:"
            cell.favorTitleLabel.text = "Driving me to Walmart"
        }
        else{
            cell.topLabel.text = "Rohit S. is awarding 2 points for:"
            cell.favorTitleLabel.text = "Doing the dishes"
        }
        
        
        return cell
    }
    
    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 108
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    

    // MARK: Navigation Menu
    
    @IBAction func navigationClick(sender: AnyObject) {
        
        if (self.favorView.frame.origin.x == 0){
            showNavigationMenu()
        }
        else{
            hideNavigationMenu()
        }
    }
    
    
    func addNavigationMenu() {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewControllerWithIdentifier("NavigationMenuViewController")
        self.view.insertSubview(controller.view, atIndex: 0)
        
        addChildViewController(controller)
        controller.didMoveToParentViewController(self)
        
    }
    
    func showNavigationMenu() {
        UIView.animateWithDuration(0.35, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: UIViewAnimationOptions.TransitionNone, animations: { self.favorView.frame.origin.x = 250}, completion: nil)
        
    }
    
    func hideNavigationMenu() {
        UIView.animateWithDuration(0.25, animations: {
            self.favorView.frame.origin.x = 0
            
        })
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
