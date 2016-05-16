//
//  ContentCell.swift
//  CaliNewsV2
//
//  Created by 翁承志 on 16/4/17.
//  Copyright © 2016年 SuperCali. All rights reserved.
//

import UIKit

class ContentCell: UITableViewCell {

    @IBOutlet weak var DateLabel: UILabel!          //日期label
    
    @IBOutlet weak var ContentImg: UIImageView!     //图片
    
    @IBOutlet weak var ContentTitle: UILabel!       //标题
    
    @IBOutlet weak var ContentText: UILabel!        //内容
    
    @IBOutlet weak var SourceText: UILabel!         //来源
    
    @IBOutlet weak var SeeFromBtn: UIButton!        //查看来源按钮
    
    @IBOutlet weak var TencBtn: UIButton!   //微博分享按钮
    @IBOutlet weak var WeiboBtn: UIButton!  //腾讯分享按钮
    @IBOutlet weak var FacebookBtn: UIButton!   //FaceBook分享按钮
    @IBOutlet weak var TwitterBtn: UIButton!    //推特分享按钮
    
    override func awakeFromNib() {
        super.awakeFromNib()
        SeeFromBtn.layer.cornerRadius = 10
        WeiboBtn.layer.cornerRadius = 25
        TencBtn.layer.cornerRadius = 25
        FacebookBtn.layer.cornerRadius = 25
        TwitterBtn.layer.cornerRadius = 25
        
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
