//
//  TopicView.swift
//  CaliTest
//
//  Created by 翁承志 on 16/4/9.
//  Copyright © 2016年 SuperCali. All rights reserved.
//

import UIKit

protocol TopicViewDelegate{                             //定义协议，这样才能将值传回ViewController
    
    func passOnInformation(VC:TopicView,value:[String])
    func passOnInformation2(VC:TopicView,value:[String])
}

class TopicView: UIViewController, UITableViewDataSource,UITableViewDelegate{
   
    var delegate:TopicViewDelegate?                     //定义delegate
    
    @IBOutlet weak var WarnLabel: UILabel!              //提示信息[ WarnLabel ]
    
    var TopicsShowed:[String] = []
    var TopicsUnused:[String] = []
    var TopicsUsed:[String] = []
    
    @IBOutlet weak var TopicTable: UITableView!         //绑定Tableview 为［ TopicTable ］
    
    @IBOutlet weak var TopicSeg: UISegmentedControl!    //选项按钮[ TopicSeg ]
    
    @IBAction func TopicSegChange(sender: AnyObject) {  //选项按钮的值变化
        
        if TopicSeg.selectedSegmentIndex == 0           //0 —— 管理我的新闻类别
        {   TopicsShowed = TopicsUsed
            if TopicsShowed == [] {
                WarnLabel.text = "你还没有设置任何想看的新闻主题。\n快去“未添加的新闻主题”里找找你感兴趣的吧！"
            }
            else { WarnLabel.text = nil }
            self.TopicTable.reloadData()
        }
        else                                            //1 —— 未添加的新闻主题
        {   TopicsShowed = TopicsUnused
            if TopicsShowed == [] {
                WarnLabel.text = "你已经添加了所有的新闻主题。\n可以去“管理我的新闻类别”里看看！"
            }
            else { WarnLabel.text = nil }
            self.TopicTable.reloadData()
        }
    }
    
    @IBAction func RightSwipe(sender: AnyObject) {          //右划
        TopicSeg.selectedSegmentIndex = 0
        TopicsShowed = TopicsUsed
        if TopicsShowed == [] {
            WarnLabel.text = "你还没有设置任何想看的新闻主题。\n快去“未添加的新闻主题”里找找你感兴趣的吧！"
        }
        self.TopicTable.reloadData()

    }
    
    @IBAction func Leftswipe(sender: AnyObject) {           //左滑
        TopicSeg.selectedSegmentIndex = 1
        TopicsShowed = TopicsUnused
        if TopicsShowed == [] {
            WarnLabel.text = "你已经添加了所有的新闻主题。\n可以去“管理我的新闻类别”里看看！"
        }
        self.TopicTable.reloadData()
    }

    
    @IBAction func CancleTapped(sender: AnyObject) {                //点击右上角X退出
        
    if (self.delegate != nil) {
            //传值
            self.delegate?.passOnInformation(self, value: TopicsUsed)
            self.delegate?.passOnInformation2(self, value: TopicsUnused)
        }

    NSUserDefaults.standardUserDefaults().setObject(TopicsUsed, forKey: "Used")
    NSUserDefaults.standardUserDefaults().setObject(TopicsUnused, forKey: "Unused")
    NSUserDefaults.standardUserDefaults().synchronize()                     //存储配置文件到本地
        
    self.dismissViewControllerAnimated(true, completion: nil)               //退出到前界面
        
    }
    
    
    override func viewDidLoad() {                                           //初始化
        super.viewDidLoad()
        
        self.TopicSeg.selectedSegmentIndex = 0
        TopicsShowed = TopicsUsed
        
        if TopicsShowed == [] {
            WarnLabel.text = "你还没有设置任何想看的新闻主题。\n快去“你丢弃的新闻主题”里找找你感兴趣的吧！"
        }
        
        self.modalPresentationStyle = .Custom       //让弹出的界面保持透明
        
        let nib = UINib(nibName: "TopicViewCell", bundle: nil)
        self.TopicTable.registerNib(nib, forCellReuseIdentifier: "TopicViewCell")      //注册自定义单元格

        self.TopicTable.editing = true      //让tableview一直处于可以编辑的状态
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    internal func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }


    internal func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TopicsShowed.count
    }
    
    internal func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        //TableView Cell 显示数据
        let cell = tableView.dequeueReusableCellWithIdentifier("TopicViewCell", forIndexPath: indexPath) as! TopicViewCell
        
        cell.backgroundColor = UIColor.clearColor()
        cell.TopicTitle.text = TopicsShowed[indexPath.row]
        cell.TopicTitle.textColor = UIColor.whiteColor()

        return cell
    }
    
    //MARK - UITableViewDeleage   调用的协议
    internal func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath){
        if editingStyle == UITableViewCellEditingStyle.Delete {     //按下删除按钮
            
            if TopicSeg.selectedSegmentIndex == 0
            {
                TopicsUnused.append(TopicsShowed[indexPath.row])      //添加被删除的项到 TopicUnused
                TopicsUsed.removeAtIndex(indexPath.row)             //删除
                TopicsShowed.removeAtIndex(indexPath.row)
            }
            else
            {
                TopicsUsed.append(TopicsShowed[indexPath.row])         //添加呗删除的项到TopicUsed
                TopicsUnused.removeAtIndex(indexPath.row)
                TopicsShowed.removeAtIndex(indexPath.row)
            }
            
            self.TopicTable.deleteRowsAtIndexPaths([indexPath], withRowAnimation: //添加删除时的动态效果
                UITableViewRowAnimation.Automatic)
        }
    }
    
//    //edit mode
    override func setEditing(editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        self.TopicTable.setEditing(editing,animated:animated)
    }
    
    func tableView(tableView: UITableView, titleForDeleteConfirmationButtonForRowAtIndexPath indexPath: NSIndexPath) -> String? {
        
        if TopicSeg.selectedSegmentIndex == 0
        { return "删除"}
        else
        {  return "添加" }         //字符显示修改
    }
    
    //move cell  移动调整 事项 的位置
    func tableView(tableView: UITableView, moveRowAtIndexPath sourceIndexPath: NSIndexPath, toIndexPath destinationIndexPath: NSIndexPath) {
        if TopicSeg.selectedSegmentIndex == 0
        {
        let topic = TopicsShowed.removeAtIndex(sourceIndexPath.row)         //插入
        TopicsUsed.removeAtIndex(sourceIndexPath.row)
        TopicsUsed.insert(topic, atIndex: destinationIndexPath.row)
        TopicsShowed.insert(topic, atIndex: destinationIndexPath.row)
        }
        else
        {
            let topic = TopicsShowed.removeAtIndex(sourceIndexPath.row)     //插入
            TopicsUnused.removeAtIndex(sourceIndexPath.row)
            TopicsUnused.insert(topic, atIndex: destinationIndexPath.row)
            TopicsShowed.insert(topic, atIndex: destinationIndexPath.row)
        }
    }
}
