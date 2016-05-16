//
//  YinyuetaiCell.swift
//  CaliTest
//
//  Created by 翁承志 on 16/4/25.
//  Copyright © 2016年 SuperCali. All rights reserved.
//

import UIKit

class YinyuetaiCell: UITableViewCell {

    @IBOutlet weak var CellImage: UIImageView!
    
    @IBOutlet weak var CellZanLabel: UILabel!
    @IBOutlet weak var CellTitle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
