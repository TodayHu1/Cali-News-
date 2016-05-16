//
//  POCOView.swift
//  CaliTest
//
//  Created by 翁承志 on 16/4/27.
//  Copyright © 2016年 SuperCali. All rights reserved.
//

import UIKit

class POCOView: UITableViewController, HomeModelProtocal {
    
    var PullUpDownRefresh:ZJRefreshControl!
    var feedItems: NSArray = NSArray()
    let homeModel = HomeModel()
    
    var URLPath:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.tableView.backgroundColor = UIColor(red: 222/255, green: 225/255, blue: 226/255, alpha: 1)
        let jeremyGif = UIImage.gifWithName("color_loading")      //导入了高手的Swift显示gif的类
        let imageView = UIImageView(image: jeremyGif)   //在加载界面显示动态加载动画
        imageView.contentMode = .Center
        self.tableView.backgroundView = imageView
        
        
        PullUpDownRefresh = ZJRefreshControl(scrollView: self.tableView,refreshBlock: {
            self.dropViewDidBeginRefreshing();
            },loadmoreBlock: {
                self.dropViewDidBeginLoadmore();
        });
        
        
                let nib = UINib(nibName: "POCOCell", bundle: nil)
                self.tableView.registerNib(nib, forCellReuseIdentifier: "POCOCell")      //注册自定义单元格
        
        homeModel.delegate = self
        homeModel.downloadItems(URLPath)
        
        
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }                                           //section数目
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return feedItems.count                             //显示的单元格数目
    }
    
    func itemsDownloaded(items: NSArray) {
        
        feedItems = items
        self.tableView.reloadData()
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("POCOCell", forIndexPath: indexPath) as! POCOCell                              //定义cell
        let news = feedItems[indexPath.row] as! NewsModel //读取新闻组中的数据存入“news”
        
        let image = cell.POCOImage           //图片
        
        image.image = UIImage(data: news.Img!, scale: 1)
        
        self.tableView.backgroundColor = UIColor(red: 76/255, green: 76/255, blue: 76/255, alpha: 1)
        self.tableView.backgroundView = nil
        return cell
        
    }
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //点击单元格
        //实例化一个界面
        let vp = DetailWebView(nibName:"DetailWebView", bundle:nil)
        
        let indexPath = tableView.indexPathForSelectedRow
        
        vp.url = ((feedItems[indexPath!.row] as? NewsModel )?.URL)!
        //将点击的单元格对应的信息传递给DetailView的 “news”变量
        
        self.navigationController!.pushViewController(vp, animated:true)    //保留bavigation bar的前提下进行页面跳转，push
    }
    
    func refreshData() {                                //刷新数据 函数
        print("REFRESHED")
        
        let homeModel = HomeModel()
        homeModel.delegate = self
        homeModel.downloadItems(URLPath)
        
        self.tableView.reloadData()     //刷新tableview的资料显示
        //结束下拉刷新必须调用
        self.PullUpDownRefresh.endRefreshing()
    }
    
    func loadMoreData() {
        print("MoreLoaded")
        let feed1 = feedItems
        let homeModel = HomeModel()
        homeModel.delegate = self
        homeModel.downloadItems(URLPath)
        if feedItems != feed1 {
            feedItems = feedItems.arrayByAddingObjectsFromArray(feedItems as [AnyObject])
            self.tableView.reloadData()
        }
        //结束加载更多必须调用
        self.PullUpDownRefresh.endLoadingmore()
        
    }
    
    func dropViewDidBeginRefreshing()->Void{            //下拉触发函数
        print("＊＊＊＊下拉刷新＊＊＊＊");
        refreshData()                                   //内容刷新函数
    }
    
    func dropViewDidBeginLoadmore()->Void{              //上拉触发函数
        print("＊＊＊＊上拉加载＊＊＊＊");
        loadMoreData()                                  //新内容加载函数
    }
    
}
