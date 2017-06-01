//
//  GuideViewController.swift
//  FansArea
//
//  Created by 闵罗琛 on 2017/5/30.
//  Copyright © 2017年 闵罗琛. All rights reserved.
//

import UIKit

class GuideViewController: UIPageViewController, UIPageViewControllerDataSource {

    var headings = ["页面1","页面2","页面3"]
    var footers = ["欢迎语1","欢迎语2","欢迎语3"]
    var images = ["pageimage1","pageimage2","pageimage3"]
    
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
        if case 0..<headings.count = atIndex{
            if let ContentVC = storyboard?.instantiateViewController(withIdentifier: "ContentView")as? ContentViewController {
                
                ContentVC.heading = headings[atIndex]
                ContentVC.footer = footers[atIndex]
                ContentVC.imageName = images[atIndex]
                ContentVC.index = atIndex
                
                return ContentVC
            }
        }
        return nil
    }
    
//    func presentationCount(for pageViewController: UIPageViewController) -> Int {
//        return headings.count
//    }
//    
//    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
//        return 0
//    }
    
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
