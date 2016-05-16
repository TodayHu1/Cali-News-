//
//  newcell.swift
//  CailiTestFail
//
//  Created by 翁承志 on 16/4/7.
//  Copyright © 2016年 SuperCali. All rights reserved.
//
//      主屏下新闻的TableView的单元格 对应newcell.xib

import UIKit

class newcell: UITableViewCell {

    @IBOutlet weak var CellImage: UIImageView!
    
    @IBOutlet weak var CellTitle: UILabel!
    
    @IBOutlet weak var DateLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
