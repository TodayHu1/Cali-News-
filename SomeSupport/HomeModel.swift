//
//  HomeModel.swift
//  CaliTest
//
//  Created by 翁承志 on 16/4/11.
//  Copyright © 2016年 SuperCali. All rights reserved.
//

import Foundation

protocol HomeModelProtocal: class {
    func itemsDownloaded(items: NSArray)
}


class HomeModel: NSObject, NSURLSessionDataDelegate {
    
    //properties
    
    weak var delegate: HomeModelProtocal!
    
    var data : NSMutableData = NSMutableData()

    func downloadItems(urlPath:String) {        //输入参数 网址 urlPath
        
        let url: NSURL = NSURL(string: urlPath)!
        print("＊＊＊＊＊＊以下为现在的数据来源网址＊＊＊＊＊＊＊＊")
        print(urlPath)
        print("＊＊＊＊＊＊以上是本次的数据来源网址＊＊＊＊＊＊\n")
        
        var session: NSURLSession!
        let configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
        
        
        session = NSURLSession(configuration: configuration, delegate: self, delegateQueue: nil)
        
        let task = session.dataTaskWithURL(url)
        
        task.resume()
        
    }
    
    func URLSession(session: NSURLSession, dataTask: NSURLSessionDataTask, didReceiveData data: NSData) {
        self.data.appendData(data);
        
    }
    
    func URLSession(session: NSURLSession, task: NSURLSessionTask, didCompleteWithError error: NSError?) {
        if error != nil {
            print("Failed to download data")
        }else {
            print("Data downloaded")
            self.parseJSON()
        }
        
    }
    
    func parseJSON() {
        
        var jsonResult: NSMutableArray = NSMutableArray()
        
        do{
            jsonResult = try NSJSONSerialization.JSONObjectWithData(self.data, options:NSJSONReadingOptions.AllowFragments) as! NSMutableArray
        } catch let error as NSError {
            print(error)
            
        }
        
        var jsonElement: NSDictionary = NSDictionary()
        let newss: NSMutableArray = NSMutableArray()
        
        for(var i = 0; i < jsonResult.count ; i += 1)               //json解析
        {
            print("＊＊＊＊＊＊json_analyze＊＊＊＊＊＊")
            jsonElement = jsonResult[i] as! NSDictionary
            let recordID = jsonElement.valueForKey("recordID")! as? String
            let URL = jsonElement.valueForKey("URL")! as? String
            let Title = jsonElement.valueForKey("Title")! as? String
            let Img = jsonElement.valueForKey("Img")! as? String
            let crawled = jsonElement.valueForKey("crawled")! as? String
            let Content = jsonElement.valueForKey("Content") as? String
            let Source = jsonElement.valueForKey("Source") as? String
            let Recommend = jsonElement.valueForKey("Recommend") as? String
            
            let new = NewsModel()
            
            //the following insures none of the JsonElement values are nil through optional binding
            
                new.recordID = recordID
                new.URL = URL
                new.Title = Title
            
            if Img  == "NoImg"                                  //无图 填充默认图片
            {
                let url : NSURL = NSURL(string:RandomPic())!
                new.Img  = NSData(contentsOfURL:url)!
            }
            else
            {let url : NSURL = NSURL(string: Img! )!
            new.Img  = NSData(contentsOfURL:url)!} //先将页面的图片读取为NSData，防止页面变卡
            
                new.crawled = String(crawled)
                new.Content = Content
                new.Source = Source
                new.Recommend = Recommend
            
            newss.addObject(new)

        }
        
        print("＊＊＊＊＊＊＊＊JsonDataFinished＊＊＊＊＊＊＊＊＊＊＊＊＊")
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            
            self.delegate.itemsDownloaded(newss)
            
        })
    }
}
