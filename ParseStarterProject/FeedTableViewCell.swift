//
//  FeedTableViewCell.swift
//  ParseStarterProject-Swift
//
//  Created by Travis Sasselli on 11/8/16.
//  Copyright © 2016 Parse. All rights reserved.
//

import UIKit

class FeedTableViewCell: UITableViewCell {

    @IBOutlet var userName: UILabel!
    @IBOutlet var postedImage: UIImageView!
    @IBOutlet var messageLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
