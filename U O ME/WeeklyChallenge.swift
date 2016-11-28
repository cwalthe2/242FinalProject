//
//  WeeklyChallenge.swift
//  U O ME
//
//  Created by Collin Walther on 11/27/16.
//  Copyright © 2016 Collin Walther, Rohit Saigal. All rights reserved.
//

import UIKit

class WeeklyChallenge: NSObject {

    var title: String
    var currPoints: Int
    var reqPoints: Int
    var reward: Int
    
    override init(){
        self.title = ""
        self.currPoints = 0
        self.reqPoints = 0
        self.reward = 0
    }
    
    init(title: String, currPoints: Int, reqPoints: Int, reward: Int){
        self.title = title
        self.currPoints = currPoints
        self.reqPoints = reqPoints
        self.reward = reward
    }
    
}
