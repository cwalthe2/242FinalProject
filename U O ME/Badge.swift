//
//  Badge.swift
//  U O ME
//
//  Created by Collin Walther on 11/10/16.
//  Copyright © 2016 Collin Walther, Rohit Saigal. All rights reserved.
//

import UIKit

class Badge: NSObject {

    let badgeImage: UIImage
    let badgeLabelText: String
    let badgeProgress: Float
    let badgeTotal: Float
    let badgeDescription : String
    
    
    init(badgeImage: UIImage, badgeLabelText: String, badgeProgress: Float, badgeTotal: Float, badgeDescription: String){
        
        self.badgeImage = badgeImage
        self.badgeLabelText = badgeLabelText
        self.badgeProgress = badgeProgress
        self.badgeTotal = badgeTotal
        self.badgeDescription = badgeDescription
        
    }
    
    class func getBadgeList() -> Array<Badge>{
        return [Badge(badgeImage: UIImage(named: "Level5_badge.png")!, badgeLabelText: "Reach level 5", badgeProgress: 1, badgeTotal: 5, badgeDescription: "Complete favors to level up!"),
        Badge(badgeImage: UIImage(named: "InviteAFriend_badge.png")!, badgeLabelText: "Invite a friend", badgeProgress: 0, badgeTotal: 5, badgeDescription: "Invite a friend to join!"),
        Badge(badgeImage: UIImage(named: "ProPic_badge.png")!, badgeLabelText: "Say cheese", badgeProgress: 0, badgeTotal: 1, badgeDescription: "Upload a profile pic to show off to your friends"),
        Badge(badgeImage: UIImage(named: "Consistent_badge.png")!, badgeLabelText: "Consistency", badgeProgress: 0, badgeTotal: 5, badgeDescription: "Complete 5 favors for 1 of your friends"),
        Badge(badgeImage: UIImage(named: "100Favors_badge.png")!, badgeLabelText: "Complete 100 favors", badgeProgress: 0, badgeTotal: 100, badgeDescription: "You're deserve a nice trophy for this achievement. Fulfill 100 of your friends favors."),
        ]
        
    
        
    }
    
}
