//
//  ReviewViewController.swift
//  FansArea
//
//  Created by 闵罗琛 on 2017/5/23.
//  Copyright © 2017年 闵罗琛. All rights reserved.
//

import UIKit

class ReviewViewController: UIViewController {
    
    var rating: String?

    @IBOutlet weak var bgimage: UIImageView!
    @IBOutlet weak var bgimageview: UIImageView!
    @IBOutlet weak var ratingStackView: UIStackView!
    
    @IBAction func ratingTap(_ sender: UIButton) {
        switch sender.tag {
        case 1:
            rating = "dislike"
        case 2:
            rating = "good"
        case 3:
            rating = "great"
        default:
            break
        }
        
        performSegue(withIdentifier: "unwindToDetailView", sender: self)
        
    }
    
    
    var area: Area!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bgimage.image = UIImage(named: area.image)
        let effect = UIBlurEffect(style: .light)
        let effectView = UIVisualEffectView(effect: effect)
        
        effectView.frame = view.frame
        bgimageview.addSubview(effectView)
        
//        ratingStackView.transform = CGAffineTransform(scaleX: 0, y: 0)
        
        let startPos = CGAffineTransform(translationX: 0, y: 500)
        let startScale = CGAffineTransform(scaleX: 0, y: 0)
        ratingStackView.transform = startScale.concatenating(startPos)
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {

//  放大动画
        UIView.animate(withDuration: 0.5) {
//            self.ratingStackView.transform = CGAffineTransform.identity
            
            let endPos = CGAffineTransform(translationX: 0, y: 0)
            let endScale = CGAffineTransform.identity
            self.ratingStackView.transform = endPos.concatenating(endScale)
            
        }

//  抖动放大动画
//        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.3, initialSpringVelocity: 0.5, options: [], animations: {
//            
//            self.ratingStackView.transform = CGAffineTransform.identity
//            
//        }, completion: nil)
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
