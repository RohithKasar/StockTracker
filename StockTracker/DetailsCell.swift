//
//  DetailsCell.swift
//  StockTracker
//
//  Created by Rohith Kasar on 7/12/19.
//  Copyright © 2019 rohith.kasar. All rights reserved.
//

import UIKit

class DetailsCell: UITableViewCell {

    var showSell = false
    
    @IBOutlet weak var sellButton: UIButton!
    @IBOutlet weak var detailsLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    
    

}
