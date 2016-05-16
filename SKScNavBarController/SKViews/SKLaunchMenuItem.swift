//
//  SKLaunchMenuItem.swift
//  SCNavController
//
//  Created by Sukun&翁承志 on 15/9/30.
//  Copyright © 2015年 Sukun&翁承志. All rights reserved.
//
//点击之后的扩展栏

import UIKit

class SKLaunchMenuItem: UICollectionViewCell {
    
    var titleLabel:UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        titleLabel = UILabel(frame: CGRectMake(0, 0, kScreenWidth / 5, 30))
        titleLabel.backgroundColor = UIColor(red: 63/255, green: 118/255, blue: 218/255, alpha: 1)
        
        titleLabel.font = UIFont(name:"Microsoft YaHei",size:14)
        titleLabel.textColor = UIColor.whiteColor()
        titleLabel.shadowColor=UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.2)//设置阴影颜色
        titleLabel.shadowOffset=CGSizeMake(1, 1)//设置阴影大小
        titleLabel.textAlignment = NSTextAlignment.Center
        
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 4
        self.layer.borderColor = UIColor.lightGrayColor().CGColor
        self.layer.borderWidth = 0.1
        self.contentView.addSubview(titleLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
