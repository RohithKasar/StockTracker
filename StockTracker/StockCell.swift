//
//  StockCell.swift
//  StockTracker
//
//  Created by Rohith Kasar on 7/12/19.
//  Copyright © 2019 rohith.kasar. All rights reserved.
//

import UIKit

class StockCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
 
    @IBOutlet weak var positionLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
