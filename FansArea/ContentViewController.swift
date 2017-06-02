//
//  ContentViewController.swift
//  FansArea
//
//  Created by 闵罗琛 on 2017/5/30.
//  Copyright © 2017年 闵罗琛. All rights reserved.
//

import UIKit

class ContentViewController: UIViewController {

    @IBOutlet weak var labelHeading: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var labelFooter: UILabel!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var btnDone: UIButton!
    
    @IBAction func btnDoneTap(_ sender: UIButton) {
        let defaults = UserDefaults.standard
        defaults.set(true, forKey: "GuideShow")
        dismiss(animated: true, completion: nil)
    }
    
    var index = 0
    var heading = ""
    var imageName = ""
    var footer = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pageControl.currentPage = index
        btnDone.isHidden = (index != 2)
        labelFooter.text = footer
        labelHeading.text = heading
        imageView.image = UIImage(named: imageName)
        
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
