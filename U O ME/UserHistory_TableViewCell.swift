//
//  UserHistory_TableViewCell.swift
//  U O ME
//
//  Created by Rohit Saigal on 11/9/16.
//  Copyright © 2016 Collin Walther, Rohit Saigal. All rights reserved.
//

import UIKit

class UserHistory_TableViewCell: UITableViewCell {

    
    @IBOutlet weak var favorFacts: UILabel!
    
    @IBOutlet weak var favorInfo: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}
