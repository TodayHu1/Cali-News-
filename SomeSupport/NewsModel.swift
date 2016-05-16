//
//  NewModel.swift
//  CaliTest
//
//  Created by 翁承志 on 16/4/11.
//  Copyright © 2016年 SuperCali. All rights reserved.
//  信息的类

import Foundation

class NewsModel: NSObject {
    
    //properties
    
    var recordID: String?
    var URL: String?
    var Title: String?
    var Img: NSData?
    var crawled: String?
    var Content: String?
    var Source: String?
    var Time: String?
    var Recommend: String?
    
    //construct with @name, @address, @latitude, and @longitude parameters
    override init()
    {
        
    }
    
    //prints object's current state
    
    init(recordID: String, URL: String, Title: String, Img: NSData, crawled: String, Content:String, Source:String, Time:String, Recommend:String ) {
        self.recordID = recordID
        self.URL = URL
        self.Title = Title
        self.Img = Img
        self.crawled = crawled
        self.Content = Content
        self.Source = Source
        self.Time = Time
        self.Recommend = Recommend
    }
}