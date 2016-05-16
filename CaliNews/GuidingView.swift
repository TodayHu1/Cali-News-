//
//  GuidingView.swift
//  CaliTest
//
//  Created by 翁承志 on 16/5/1.
//  Copyright © 2016年 SuperCali. All rights reserved.
//

import UIKit

class GuidingView: UIViewController {

    var TappedTimes: Int = 0
    @IBOutlet weak var ImageView: UIImageView!
    @IBOutlet weak var Btn1: UIButton!
    @IBOutlet weak var Btn2: UIButton!
    
    @IBOutlet weak var Btn0: UIButton!
    @IBOutlet weak var Btn0Label: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        Btn1.layer.cornerRadius = 5
        Btn2.layer.cornerRadius = 5
        Btn0.layer.cornerRadius = 5
        Btn0Label.text = "下一条"
        // Do any additional setup after loading the view.
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func Btn1Tapped(sender: AnyObject) {
        TappedTimes = 0
        ImageView.image = UIImage(named: "mainguide")
        Btn1.backgroundColor = UIColor(red: 229/255, green: 229/255, blue: 229/255, alpha: 1)
        Btn2.backgroundColor = UIColor(red: 229/255, green: 229/255, blue: 229/255, alpha: 0.2)
        Btn0Label.text = "下一条"
    }
    
    @IBAction func Btn2Tapped(sender: AnyObject) {
        TappedTimes = 1
        ImageView.image = UIImage(named: "topicguide")
        Btn2.backgroundColor = UIColor(red: 229/255, green: 229/255, blue: 229/255, alpha: 1)
        Btn1.backgroundColor = UIColor(red: 229/255, green: 229/255, blue: 229/255, alpha: 0.2)
        Btn0Label.text = "结束"
    }
    
    @IBAction func Btn0Tapped(sender: AnyObject) {
        if TappedTimes == 0 {
            TappedTimes = 1
            ImageView.image = UIImage(named: "topicguide")
            Btn2.backgroundColor = UIColor(red: 229/255, green: 229/255, blue: 229/255, alpha: 1)
            Btn1.backgroundColor = UIColor(red: 229/255, green: 229/255, blue: 229/255, alpha: 0.2)
            Btn0Label.text = "结束"
        }
        else {
                self.dismissViewControllerAnimated(true, completion: nil)               //退出到前界面
        }
        
    }
    
    

}
