//
//  Badges_ViewController.swift
//  U O ME
//
//  Created by Collin Walther on 11/10/16.
//  Copyright © 2016 Collin Walther, Rohit Saigal. All rights reserved.
//

import UIKit

class Badges_ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, NavigationMenu_ViewControllerDelegate{

    @IBOutlet weak var wholeView: UIView!
    @IBOutlet weak var badgesCollectionView: UICollectionView!
    //fileprivate let sectionInsets = UIEdgeInsets(top: 50.0, left: 20.0, bottom: 50.0, right: 20.0)
    //fileprivate let itemsPerRow: CGFloat = 3
    let badgeList: Array<Badge> = Badge.getBadgeList()
    
    let numSections: Int = 2
    let numInSections: Int = 3
    
    override func viewDidLoad() {
        super.viewDidLoad()

        badgesCollectionView.register(UINib(nibName: "Badge_CollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "Badge Cell")
     
        addNavigationMenu()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    
    // MARK: - Collection View data source
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return numSections
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if (section == 1){
            return 2
        }
        return numInSections
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Badge Cell",
                                                      for: indexPath) as! Badge_CollectionViewCell
        
        let index :Int = (indexPath.section * 3) + indexPath.item
        
        if (index < badgeList.count){
            cell.configureCell(badge: badgeList[index])
        }
        
        return cell
        
    }
    
    
    // MARK: - Collection View delegate
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("selected cell")
        let index :Int = (indexPath.section * 3) + indexPath.item
        let badge: Badge = badgeList[index]
        
        let backdrop: UIView = UIView(frame: CGRect(x: 0, y: 0, width: wholeView.frame.width, height: wholeView.frame.height))
        wholeView.addSubview(backdrop)
        backdrop.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        backdrop.isUserInteractionEnabled = true
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.exitBadgeFocus(gestureRecognizer:)))
        backdrop.addGestureRecognizer(tapRecognizer)
        
        let backgroundView = UIView()
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        backdrop.addSubview(backgroundView)
        backgroundView.backgroundColor = UIColor.yellow
        let bgHorizontalConstraint = NSLayoutConstraint(item: backgroundView, attribute: NSLayoutAttribute.centerX, relatedBy: NSLayoutRelation.equal, toItem: backdrop, attribute: NSLayoutAttribute.centerX, multiplier: 1, constant: 0)
        let bgVerticalConstraint = NSLayoutConstraint(item: backgroundView, attribute: NSLayoutAttribute.centerY, relatedBy: NSLayoutRelation.equal, toItem: backdrop, attribute: NSLayoutAttribute.centerY, multiplier: 1, constant: 0)
        let bgWidthConstraint = NSLayoutConstraint(item: backgroundView, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: 200)
        let bgHeightConstraint = NSLayoutConstraint(item: backgroundView, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: 260)
        backdrop.addConstraints([bgHorizontalConstraint, bgVerticalConstraint, bgWidthConstraint, bgHeightConstraint])
        
        
        let badgeImage = UIImageView()
        badgeImage.translatesAutoresizingMaskIntoConstraints = false
        badgeImage.image = badge.badgeImage
        backgroundView.addSubview(badgeImage)
        let biHorizontalConstraint = NSLayoutConstraint(item: badgeImage, attribute: NSLayoutAttribute.centerX, relatedBy: NSLayoutRelation.equal, toItem: backgroundView, attribute: NSLayoutAttribute.centerX, multiplier: 1, constant: 0)
        let biVerticalConstraint = NSLayoutConstraint(item: badgeImage, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: backgroundView, attribute: NSLayoutAttribute.top, multiplier: 1, constant: 25)
        let biWidthConstraint = NSLayoutConstraint(item: badgeImage, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: 90)
        let biHeightConstraint = NSLayoutConstraint(item: badgeImage, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: 90)
        backgroundView.addConstraints([biHorizontalConstraint, biVerticalConstraint, biWidthConstraint, biHeightConstraint])
        
        
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = badge.badgeLabelText
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont(name: "Avenir", size: 14)
        backgroundView.addSubview(titleLabel)
        let tlHorizontalConstraint = NSLayoutConstraint(item: titleLabel, attribute: NSLayoutAttribute.centerX, relatedBy: NSLayoutRelation.equal, toItem: backgroundView, attribute: NSLayoutAttribute.centerX, multiplier: 1, constant: 0)
        let tlVerticalConstraint = NSLayoutConstraint(item: titleLabel, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: badgeImage, attribute: NSLayoutAttribute.bottom, multiplier: 1, constant: 5)
        let tlWidthConstraint = NSLayoutConstraint(item: titleLabel, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.width, multiplier: 1, constant: 200)
        let tlHeightConstraint = NSLayoutConstraint(item: titleLabel, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: 30)
        backgroundView.addConstraints([tlHorizontalConstraint, tlVerticalConstraint, tlWidthConstraint, tlHeightConstraint])
        
        
        
        let progLabel = UILabel()
        progLabel.translatesAutoresizingMaskIntoConstraints = false
        let p = NSString(format: "%.0f", badge.badgeProgress)
        let t = NSString(format: "%.0f", badge.badgeTotal)
        progLabel.text = "\(p) / \(t)"
        progLabel.textAlignment = .center
        progLabel.numberOfLines = 0
        progLabel.font = UIFont(name: "Avenir", size: 14)
        backgroundView.addSubview(progLabel)
        let plHorizontalConstraint = NSLayoutConstraint(item: progLabel, attribute: NSLayoutAttribute.centerX, relatedBy: NSLayoutRelation.equal, toItem: backgroundView, attribute: NSLayoutAttribute.centerX, multiplier: 1, constant: 0)
        let plVerticalConstraint = NSLayoutConstraint(item: progLabel, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: titleLabel, attribute: NSLayoutAttribute.bottom, multiplier: 1, constant: 5)
        let plWidthConstraint = NSLayoutConstraint(item: progLabel, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.width, multiplier: 1, constant: 200-20)
        let plHeightConstraint = NSLayoutConstraint(item: progLabel, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: 30)
        backgroundView.addConstraints([plHorizontalConstraint, plVerticalConstraint, plWidthConstraint, plHeightConstraint])
        
        
        
        let descLabel = UILabel()
        descLabel.translatesAutoresizingMaskIntoConstraints = false
        descLabel.text = badge.badgeDescription
        descLabel.textAlignment = .center
        descLabel.numberOfLines = 0
        descLabel.font = UIFont(name: "Avenir", size: 14)
        backgroundView.addSubview(descLabel)
        let dlHorizontalConstraint = NSLayoutConstraint(item: descLabel, attribute: NSLayoutAttribute.centerX, relatedBy: NSLayoutRelation.equal, toItem: backgroundView, attribute: NSLayoutAttribute.centerX, multiplier: 1, constant: 0)
        let dlVerticalConstraint = NSLayoutConstraint(item: descLabel, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: progLabel, attribute: NSLayoutAttribute.bottom, multiplier: 1, constant: 0)
        let dlWidthConstraint = NSLayoutConstraint(item: descLabel, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.width, multiplier: 1, constant: 200-20)
        let dlHeightConstraint = NSLayoutConstraint(item: descLabel, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: 80)
        backgroundView.addConstraints([dlHorizontalConstraint, dlVerticalConstraint, dlWidthConstraint, dlHeightConstraint])
        
    }

    
    func exitBadgeFocus(gestureRecognizer: UITapGestureRecognizer) {
        let backdrop = gestureRecognizer.view!
        backdrop.removeFromSuperview()
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
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
