//
//  DetailView.swift
//  CaliNewsV2
//
//  Created by 翁承志 on 16/4/17.
//  Copyright © 2016年 SuperCali. All rights reserved.
//

import UIKit
import Social

class DetailView: UITableViewController {
    
    var news:NewsModel?
    var date:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.estimatedRowHeight = 100
        self.tableView.rowHeight = UITableViewAutomaticDimension        //让单元格的高度根据内容的实际高度而自适应，但要注意单元格中的空间都要添加约束，并且添加的约束能计算出单元格的高度（要确保top 和 bottom 间能计算）
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        let nib = UINib(nibName: "ContentCell", bundle: nil)
        self.tableView.registerNib(nib, forCellReuseIdentifier: "ContentCell")      //注册自定义单元格

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }


    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("ContentCell", forIndexPath: indexPath) as! ContentCell                              //定义cell
        
        
        let image = cell.ContentImg              //图片
        let title = cell.ContentTitle             //标题
        let text = cell.ContentText               //日期
        let source = cell.SourceText              //内容
        let date = cell.DateLabel                 //日期
        let button0 = cell.SeeFromBtn              //原文按钮
        let button1 = cell.TencBtn                  //腾讯按钮
        let button2 = cell.WeiboBtn                 //微博按钮
        let button3 = cell.FacebookBtn              //脸书按钮
        let button4 = cell.TwitterBtn               //推特按钮
        
        button0.addTarget(self, action: #selector(DetailView.SeeFrom), forControlEvents: UIControlEvents.TouchUpInside)
        button1.addTarget(self, action: #selector(DetailView.TencShare), forControlEvents: UIControlEvents.TouchUpInside)
        button2.addTarget(self, action: #selector(DetailView.WeiboShare), forControlEvents: UIControlEvents.TouchUpInside)
        button3.addTarget(self, action: #selector(DetailView.FacebookShare), forControlEvents: UIControlEvents.TouchUpInside)
        button4.addTarget(self, action: Selector("TwitterBtn"), forControlEvents: UIControlEvents.TouchUpInside)
        
        //        image.layer.cornerRadius = 6;
        //        image.layer.masksToBounds = true;   //imageview圆角
        
        image.image = UIImage(data: news!.Img!, scale: 1)
        
        title.text = news!.Title

        //以下主要是为了能设置UILabel的行距
        let originString = news?.Content
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 11
        paragraphStyle.firstLineHeadIndent = 0 //默认0
        
        let attr = [NSParagraphStyleAttributeName:paragraphStyle, NSBackgroundColorAttributeName:UIColor.clearColor(), NSUnderlineStyleAttributeName:0, NSUnderlineColorAttributeName:UIColor.blackColor(), NSFontAttributeName:UIFont.systemFontOfSize(18)]

        let attrString = NSAttributedString(string: originString!, attributes: attr)
        text.attributedText = attrString;

        //以上主要是为了设置UILabel的行距
        
        source.text = "来源：" + news!.Source!
    
        date.text = "获取时间：" + news!.Time!          //显示刷新时的时间

        return cell
    }
    
    func SeeFrom(){                                 //点击按钮触发的事件
        let vc = DetailWebView(nibName:"DetailWebView", bundle:nil)

        vc.url = (self.news?.URL)!
        self.navigationController!.pushViewController(vc, animated:true)    //保留bavigation bar的前提下进行页面跳转，push
       
    }
    
    func WeiboShare() {             //微博分享
        let controller: SLComposeViewController =
        SLComposeViewController(forServiceType: SLServiceTypeSinaWeibo)
        controller.setInitialText("Cali新闻分享： " + "《" + (news?.Title)! + "》\n" + "  原文地址：" + (news?.URL)! )

        self.presentViewController(controller, animated: true, completion: nil)
        
    }
    
    func TencShare() {              //腾讯微博分享
        let controller: SLComposeViewController =
        SLComposeViewController(forServiceType: SLServiceTypeTencentWeibo)
        controller.setInitialText("Cali新闻分享： " + "《" + (news?.Title)! + "》\n" + "  原文地址：" + (news?.URL)! )
        
        self.presentViewController(controller, animated: true, completion: nil)
        
    }
    //FB和TW不能用，防止闪退，所以将这两者的部分功能备注掉
    
    func FacebookShare() {
//        let controller: SLComposeViewController =
//        SLComposeViewController(forServiceType: SLServiceTypeFacebook)
//        controller.setInitialText("Cali新闻分享： " + "《" + (news?.Title)! + "》\n" + "  原文地址：" + (news?.URL)! )
//        self.presentViewController(controller, animated: true, completion: nil)
    }
    
    func TwitterShare() {
        
//        let controller: SLComposeViewController =
//        SLComposeViewController(forServiceType: SLServiceTypeTwitter)
//        controller.setInitialText("Cali新闻分享： " + "《" + (news?.Title)! + "》\n" + "  原文地址：" + (news?.URL)! )
//        
//        self.presentViewController(controller, animated: true, completion: nil)
        
    }

}
