//
//  ViewController.swift
//  CaliNews
//
//  Created by 翁承志 on 16/3/14.
//  Copyright © 2016年 SuperCali. All rights reserved.
//
//             主界面，对应main.storyboard

import UIKit

var refreshControl:ZJRefreshControl!

var TopicsNow:[UITableViewController] = []

var TopicsUsed:[String] = []
var TopicsUnused:[String] = []

class ViewController: UIViewController,TopicViewDelegate {//添加两个协议
    
    var v4 = NewsView()
    var v5 = NewsView()
    var v6 = NewsView()
    var v8 = POCOView()
    var v7 = NewsView()
    var v9 = NewsView()
    var v10 = NewsView()
    var v11 = NewsView()
    var v3 = YinyuetaiView()
    var v2 = ZhihuView()
    
    var v12 = NewsView()
    var v13 = NewsView()
    var v14 = NewsView()
    
    func passOnInformation(VC: TopicView, value: [String]) {
        //接收数据
        TopicsUsed = value
    }
    
    func passOnInformation2(VC: TopicView, value: [String]) {
        TopicsUnused = value
    }
    
    @IBAction func TopicMenuTapped(sender: AnyObject) {             //点击菜单按钮
        let va = TopicView(nibName:"TopicView", bundle:nil)
        va.delegate = self
        va.TopicsUsed = TopicsUsed
        va.TopicsUnused = TopicsUnused
        va.view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3)
        self.presentViewController(va, animated:true, completion:nil)
    }

    @IBAction func RENEW(sender: AnyObject) {
        ReloadView()
    }

//＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊ViewDidLoad——BEGIN＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊
    override func viewDidLoad() {                                               //初始状态
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
            v14.title = "军事"        //我们的网站已经关闭了，你可以自己建立一个json的网页来展示信息
            v14.URLPath = "http://1.calitencent.applinzi.com/"
            v13.title = "汽车"
            v13.URLPath = "http://1.tencentmobile.applinzi.com/"
            v12.title = "国际"
            v12.URLPath = "http://1.tencentworld.applinzi.com/"
            v11.title = "国内"
            v11.URLPath = "http://1.calinews11.applinzi.com/"
            v10.title = "厦门"
            v10.URLPath = "http://1.calinews10.applinzi.com/"
            v9.title = "体育"
            v9.URLPath = "http://1.calinews9.applinzi.com/"
            v8.title = "POCO美图"
            v8.URLPath = "http://1.calinews8.applinzi.com/"
            v7.title = "科技"
            v7.URLPath = "http://1.calinews7.applinzi.com/"
            v6.title = "财经"
            v6.URLPath = "http://1.calinews6.applinzi.com/"
            v5.title = "娱乐"
            v5.URLPath = "http://1.calinews5.applinzi.com/"
            v4.title = "健康"
            v4.URLPath = "http://1.calinews4.applinzi.com/"
            v3.title = "音悦台"
            v3.URLPath = "http://1.calinews3.applinzi.com/"
            v2.title = "知乎特约"
            v2.URLPath = "http://1.calinews2.applinzi.com/"
        //判断是否第一次启动：
        if((NSUserDefaults.standardUserDefaults().boolForKey("IsFirstLaunch") as Bool!) == false){
            //第一次启动，播放引导页面
            print("第一次启动")
            let vd = GuidingView(nibName:"GuidingView", bundle:nil)                 //引导页面
            vd.view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3)
            vd.modalTransitionStyle = UIModalTransitionStyle.CrossDissolve
            self.presentViewController(vd, animated:true, completion:nil)
            //设置为非第一次启动
            NSUserDefaults.standardUserDefaults().setBool(true, forKey: "IsFirstLaunch")
            
            let Topics0 = [v11,v7,v10,v5,v6,v4,v9,v2,v3,v8,v12,v13,v14]
            let skScNavC = SKScNavViewController(subViewControllers: Topics0)
            skScNavC.addParentController(self)
            for index in Topics0
            {
                TopicsUsed.append(index.title!)
            }
            NSUserDefaults.standardUserDefaults().setObject(TopicsUsed, forKey: "Used")
            NSUserDefaults.standardUserDefaults().setObject(TopicsUnused, forKey: "Unused")
            //设置同步
            NSUserDefaults.standardUserDefaults().synchronize()
        }
        else{
            //读取上次配置
            TopicsUsed = NSUserDefaults.standardUserDefaults().valueForKey("Used") as! [String]!
            TopicsUnused = NSUserDefaults.standardUserDefaults().valueForKey("Unused") as! [String]!
            print("不是第一次启动")
            ReloadView()
        }
        
    }
//＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊ViewDidLoad——END＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊
 func ReloadView() {

    TopicsNow = []
        for index in TopicsUsed
        {
            switch index {
            case "国内" : TopicsNow.append(v11)
            case "厦门" :TopicsNow.append(v10)
            case "体育" :TopicsNow.append(v9)
            case "POCO美图" :TopicsNow.append(v8)
            case "科技" :TopicsNow.append(v7)
            case "财经" :TopicsNow.append(v6)
            case "娱乐" :TopicsNow.append(v5)
            case "健康" :TopicsNow.append(v4)
            case "音悦台" :TopicsNow.append(v3)
            case "知乎特约" :TopicsNow.append(v2)
            case "国际" :TopicsNow.append(v12)
            case "汽车" :TopicsNow.append(v13)
            case "军事" :TopicsNow.append(v14)
            default: print("Topic_not_Find")
            }
        }
        let skScNavC2 = SKScNavViewController(subViewControllers: TopicsNow)
        
        skScNavC2.addParentController(self)       

    }
    
    override func viewDidAppear(animated: Bool) {       //自定义navigation bar
        // 1
        let nav = self.navigationController?.navigationBar
        
        // 设置navigation bar的字体颜色为白色
        nav?.tintColor = UIColor.whiteColor()

        
        ////设置图片为navigation bar 的title
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 122, height: 20))
        imageView.contentMode = .ScaleAspectFit //scaleaspectfit形式
        let image = UIImage(named: "calinews")
        imageView.image = image
        navigationItem.titleView = imageView
        
    }
}
//ViewController 到此结束


func RandomPic() ->String                   //随机备用图片函数
{
    let pictures = ["http://a.picphotos.baidu.com/album/s%3D1000%3Bq%3D90/sign=e9831f6e3edbb6fd215be12639149069/d439b6003af33a875109ab8fc15c10385343b53b.jpg",
        "http://g.picphotos.baidu.com/album/s%3D1000%3Bq%3D90/sign=5778ee6a3cc79f3d8be1e0308a91f660/0df3d7ca7bcb0a466c5a20ac6c63f6246b60af2f.jpg",
        "http://e.picphotos.baidu.com/album/s%3D1000%3Bq%3D90/sign=00e79d9e5cb5c9ea66f307e3e5098d71/ac6eddc451da81cb0da728585566d016082431e5.jpg",
        "http://a.picphotos.baidu.com/album/s%3D1000%3Bq%3D90/sign=5924521a6b81800a6ae58d0e8105088b/8b13632762d0f70319f33e490ffa513d2797c5e6.jpg",
        "http://d.picphotos.baidu.com/album/s%3D1000%3Bq%3D90/sign=0b61877dbb3eb13540c7b3bb962e93a2/f603918fa0ec08fada56b8325eee3d6d54fbdad5.jpg",
        "http://g.picphotos.baidu.com/album/s%3D1000%3Bq%3D90/sign=f488c98916dfa9ecf92e521752e0cc72/d058ccbf6c81800a1f83229bb63533fa838b47c4.jpg",
        "http://h.picphotos.baidu.com/album/s%3D1000%3Bq%3D90/sign=bca11c2ea11ea8d38e227004a73a0b3f/503d269759ee3d6ddaa02c5e44166d224e4adec5.jpg",
        "http://f.picphotos.baidu.com/album/s%3D1000%3Bq%3D90/sign=6856ec2e4010b912bbc1f2fef3cdc772/f7246b600c3387444ebf84e9560fd9f9d72aa029.jpg",
        "http://a.picphotos.baidu.com/album/s%3D1000%3Bq%3D90/sign=c92a9786da54564ee165e03983eea7f3/03087bf40ad162d972adc98916dfa9ec8b13cde0.jpg"]
    let num = arc4random_uniform(9)
    let PictureUrl = pictures[Int(num)]
    return PictureUrl
}
