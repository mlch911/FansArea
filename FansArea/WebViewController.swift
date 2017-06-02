//
//  WebViewController.swift
//  FansArea
//
//  Created by 闵罗琛 on 2017/6/2.
//  Copyright © 2017年 闵罗琛. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController {
    @IBOutlet weak var webView: UIWebView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        运用WKWebView
        let wkWeb = WKWebView(frame: view.frame)
        view.addSubview(wkWeb)
        wkWeb.load(URLRequest(url: URL(string: "https://github.com/mlch911")!))
        wkWeb.autoresizingMask = [.flexibleHeight]

//        运用WebView
//        if let url = URL(string: "https://github.com/mlch911"){
//            webView.loadRequest(URLRequest(url: url))
//        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
