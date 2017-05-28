//
//  MapViewController.swift
//  FansArea
//
//  Created by 闵罗琛 on 2017/5/25.
//  Copyright © 2017年 闵罗琛. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var map: MKMapView!
    var area: Area!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let coder = CLGeocoder()
        coder.geocodeAddressString(area.name, completionHandler: { (ps, error) in
            guard ps != nil else{
                print(error ?? "未知错误")
                return
            }
            
            let place = ps?.first
            let mark = MKPointAnnotation()
            mark.title = self.area.name
            mark.subtitle = self.area.province
            
            if let loc = place?.location {
                mark.coordinate = loc.coordinate
                self.map.showAnnotations([mark], animated: true)
                self.map.selectAnnotation(mark, animated: true)
            }
        })

        // Do any additional setup after loading the view.
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation{
            return nil
        }
        
        let id = "myannotation"
        var av = mapView.dequeueReusableAnnotationView(withIdentifier: id)as? MKPinAnnotationView
        
        if av == nil{
            av = MKPinAnnotationView(annotation: annotation, reuseIdentifier: id)
            av?.canShowCallout = true
        }
        
        let leftIconView = UIImageView(frame: CGRect(x: 0, y: 0, width: 53, height: 53))
        leftIconView.image = UIImage(named: area.image)
        av?.leftCalloutAccessoryView = leftIconView
//        av?.pinTintColor = UIColor.green
        
        return av
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
