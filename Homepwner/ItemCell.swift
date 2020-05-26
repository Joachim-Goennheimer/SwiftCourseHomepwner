//
//  ItemCell.swift
//  Homepwner
//
//  Created by Joachim Goennheimer on 25.05.20.
//  Copyright © 2020 Joachim Goennheimer. All rights reserved.
//

// import Foundation

import UIKit

class ItemCell: UITableViewCell {
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var valueLabel: UILabel!
    @IBOutlet var serialNumberLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        nameLabel.adjustsFontForContentSizeCategory = true
        serialNumberLabel.adjustsFontForContentSizeCategory = true
        valueLabel.adjustsFontForContentSizeCategory = true
    }
}
