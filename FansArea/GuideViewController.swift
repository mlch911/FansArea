//
//  GuideViewController.swift
//  FansArea
//
//  Created by 闵罗琛 on 2017/5/30.
//  Copyright © 2017年 闵罗琛. All rights reserved.
//

import UIKit

class GuideViewController: UIPageViewController, UIPageViewControllerDataSource {

    var headings = [""]
    
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        var index = (viewController as! ContentViewController).index
        index -= 1
        return vc(atIndex: index)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        var index = (viewController as! ContentViewController).index
        index += 1
        return vc(atIndex: index)
    }
    
    func vc(atIndex: Int) -> ContentViewController? {
        if case 0..<heading.count = atIndex{
            if let ContentVC = storyboard?.instantiateViewController(withIdentifier: "ContentView")as? ContentViewController {
                ContentVC.heading = heading[atIndex]
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        dataSource = self
        
        if let startVC = vc(atIndex: 0) {
            setViewControllers([startVC], direction: .forward, animated: true, completion: nil)
        }
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
