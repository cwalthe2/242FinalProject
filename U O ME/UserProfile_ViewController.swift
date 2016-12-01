//
//  UserProfile.swift
//  U O ME
//
//  Created by Rohit Saigal on 11/2/16.
//  Copyright © 2016 Collin Walther, Rohit Saigal. All rights reserved.
//

import UIKit


class UserProfile: UIViewController, UITableViewDelegate, UITableViewDataSource, NavigationMenu_ViewControllerDelegate {
    
    @IBOutlet weak var userPicture: UIImageView!
    @IBOutlet weak var favorHistory: UITableView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userLevel: UILabel!
    var user:User!
    var value:User!
    
    @IBOutlet weak var wholeView: UIView!
    @IBOutlet weak var leaderboardProgressView: LeaderboardProgress!
    @IBOutlet weak var leaderboardProgressLabel: UILabel!
    
    
    @IBOutlet weak var weekTitleLabel: UILabel!
    @IBOutlet weak var weekProgressBar: UIProgressView!
    @IBOutlet weak var weekProgressLabel: UILabel!
    var challenge: WeeklyChallenge = WeeklyChallenge()
    @IBOutlet weak var checkmarkImageView: UIImageView!
    @IBOutlet weak var weekRewardLabel: UILabel!
    
    
    @IBOutlet weak var badge1ImageView: UIImageView!
    @IBOutlet weak var badge1Label: UILabel!
    @IBOutlet weak var badge2ImageView: UIImageView!
    @IBOutlet weak var badge2Label: UILabel!
    @IBOutlet weak var badge3ImageView: UIImageView!
    @IBOutlet weak var badge3Label: UILabel!
    @IBOutlet weak var badge4ImageView: UIImageView!
    @IBOutlet weak var badge4Label: UILabel!
    
    
    /*
 set up a fake data base of friends */
    var friends=[User(name: "Collin", level: 0, image:UIImage(named:"profile_icon  30x30.png")!, points:0),User(name: "Nitish", level: 0, image:UIImage(named:"profile_icon  30x30.png")!, points:0),User(name: "Jayme", level: 0, image:UIImage(named:"profile_icon  30x30.png")!, points:0)]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()        
        
        /* set up a user, unless user has already been initialized in which case it is overwritten */
            user=User(name: "Rohit", level: 0, image:UIImage(named:"profile_icon  30x30.png")!, points:0)
            let rideHome=Favor(value: 2, recipient: friends[0], favorDescription: "Can you give me a ride home from grainger?")
            user.favorHistory.append(rideHome)
        
        if let currUser=value{
            user=currUser
        }
        
        loadProPic()
        
        print(user.favorHistory.count)
        userName.text=user.name
        userLevel.text="Level: " + String(user.level)
        
        badge1Label.text = "Complete 100 favors"
        badge2Label.text = "Invite a friend"
        badge3Label.text = "Consistency"
        badge4Label.text = "Say cheese"
        
        
        
        //favorHistory.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        
        
        favorHistory.register(UINib(nibName: "UserHistory_TableViewCell", bundle: nil), forCellReuseIdentifier: "FavorCell")
        // Do any additional setup after loading the view, typically from a nib.
        
        
        
        
        leaderboardProgressView.initBar()
        loadWeeklyChallenge()
        checkmarkImageView.isHidden = true
        
        
        self.addNavigationMenu()
    
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

    @IBAction func addPoints(_ sender: Any) {
        addToLeaderboard(num: 6)
    }
    
    
    func addToLeaderboard(num: Int){
        leaderboardProgressView.addPoints(points: num)
        userLevel.text = "Level \(leaderboardProgressView.getRank())"
        
        let points = leaderboardProgressView.getRankPoints()
        let max = Int(leaderboardProgressView.getMaxPointsFromRank())
        leaderboardProgressLabel.text = "\(points) / \(max)"
    }
    
    
    func loadWeeklyChallenge(){
        // fetch current challenge from database
        let title = "Complete 5 favors"
        let reqPoints = 5
        let rew = 5
        // ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
        
        challenge = WeeklyChallenge(title: title, currPoints: 0, reqPoints: reqPoints, reward: rew)
        
        weekTitleLabel.text = title
        weekProgressLabel.text = "0/\(reqPoints)"
        weekProgressBar.progress = 0
        weekRewardLabel.text = "\(rew) Points"
    }
    
    func updateWeeklyChallenge(){
        weekProgressLabel.text = "\(challenge.currPoints)/\(challenge.reqPoints)"
        
        let prog = Float(challenge.currPoints)/Float(challenge.reqPoints)
        weekProgressBar.progress = prog
        
        if prog == 1{
            if checkmarkImageView.isHidden == true{
                    checkmarkImageView.isHidden = false
                addToLeaderboard(num: challenge.reward)
            }
        }
    }
    
    func addToWeeklyChallenge(num: Int){
        print("here now")
        if checkmarkImageView.isHidden == true{
            print("Adding:", num)
            challenge.currPoints += num
            if challenge.currPoints > challenge.reqPoints{
                challenge.currPoints = challenge.reqPoints
            }
            
            updateWeeklyChallenge()
        }
    }
    
    
    @IBAction func addToWeekly(_ sender: Any) {
        print("here")
        addToWeeklyChallenge(num: 1)
    }
    
    
    
    func loadProPic(){
        if let imageData: NSData = UserDefaults.standard.value(forKey: "proPicData") as? NSData{
            
            let userProfileImage = UIImage(data: imageData as Data)
            self.userPicture.image = userProfileImage
        }
        else{
            
        }
    }
    
    func tableView(_ tableView:UITableView, numberOfRowsInSection section:Int) -> Int
    {
        print(user.favorHistory.count)
        return user.favorHistory.count
        
    }
    
    /*
    defines the cell that will be shown in a user's profile 
 */
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = favorHistory.dequeueReusableCell(withIdentifier: "FavorCell", for: indexPath as IndexPath) as! UserHistory_TableViewCell
 
         let currFavor=user.favorHistory[indexPath.row]
        
        cell.favorFacts.text = currFavor.recipient.name+" earned "+String(currFavor.value) + " points from " + user.name+" for:"
        
        cell.favorInfo.text = currFavor.favorDescription as String
        
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "toRequest"){
            let requestFavor = (segue.destination as! RequestFavor)
            requestFavor.value = user
            requestFavor.friends=friends
        }
        if(segue.identifier == "ProfileToFavorFeed"){
            let favorFeed = (segue.destination as! FavorFeed_ViewController)
            favorFeed.value = user
            favorFeed.friends=friends
        }
    }
/*
    @IBAction func requestFavor(sender: UIButton) {
        let storyboard = UIStoryboard(name: "User Profile", bundle:nil)
        let controller = storyboard.instantiateViewControllerWithIdentifier("Request Favor")
        self.presentViewController(controller,animated:true,completion:nil)
        
        
        
    }
*/
    
    
    

    
    
    // MARK: Navigation Menu
    
    @IBAction func navigationClick(_ sender: AnyObject) {
        print("Click nav button")
        if (self.wholeView.frame.origin.x == 0){
            print("Clidsfsd")
            showNavigationMenu()
        }
        else{
            print("d23qton")
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

    
    
    
    
    
}




