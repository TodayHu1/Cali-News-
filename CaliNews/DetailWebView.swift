//
//  DetailWebView.swift
//  CaliTest
//
//  Created by 翁承志 on 16/4/13.
//  Copyright © 2016年 SuperCali. All rights reserved.
//

import UIKit

class DetailWebView: UIViewController {

    var url:String = ""
    @IBOutlet weak var WebView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let myURL = NSURL(string: url);
        let myURLRequest:NSURLRequest = NSURLRequest(URL: myURL!);
        WebView.loadRequest(myURLRequest);
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
