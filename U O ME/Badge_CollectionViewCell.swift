//
//  Badge_CollectionViewCell.swift
//  U O ME
//
//  Created by Collin Walther on 11/10/16.
//  Copyright © 2016 Collin Walther, Rohit Saigal. All rights reserved.
//

import UIKit

class Badge_CollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var badgeImageView: UIImageView!
    @IBOutlet weak var badgeLabel: UILabel!
    @IBOutlet weak var badgeProgressView: UIProgressView!
    var badgeDescription : String!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    
    
    
    func configureCell(badge: Badge){
        self.badgeImageView.image = badge.badgeImage
        self.badgeLabel.text = badge.badgeLabelText
        self.badgeProgressView.progress = badge.badgeProgress/badge.badgeTotal
    }

}
