//
//  MenuItem_TableViewCell.swift
//  U O ME
//
//  Created by Collin Walther on 11/8/16.
//  Copyright © 2016 Collin Walther, Rohit Saigal. All rights reserved.
//

import UIKit

class MenuItem_TableViewCell: UITableViewCell {

    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var itemLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func configureCell(_ menuItem: NavigationMenu_ViewController.menuItem) {
        itemImageView.image = menuItem.img
        itemLabel.text = menuItem.name
    }
    
}
