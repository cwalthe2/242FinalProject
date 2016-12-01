//
//  User.swift
//  U O ME
//
//  Created by Rohit Saigal on 11/8/16.
//  Copyright © 2016 Collin Walther, Rohit Saigal. All rights reserved.
//

import UIKit

class User: NSObject {
    let name: String
    let level: NSInteger
    let picture: UIImage
    let favorPoints:NSInteger
    var pendingFavors=[Favor]()
    var requestedFavors=[Favor]()
    var favorHistory=[Favor]()
    init(name: String, level:NSInteger, image:UIImage, points:NSInteger){
        self.name=name
        self.level=level
        self.picture=image
        self.favorPoints=points
        
        
    }
}
