//
//  TableViewCell.swift
//  Table View Buttons
//
//  Created by Sayanee Basu on 30/1/16.
//  Copyright © 2016 Sayanee Basu. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
