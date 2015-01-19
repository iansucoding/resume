//
//  MapViewController.swift
//  TaipeiHotelPin
//
//  Created by 蘇百彥 on 2015/1/16.
//  Copyright (c) 2015年 IanSuCoding. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    var hotel:Hotel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // Convert address to coordinate and annotate it on map
        let geoCoder = CLGeocoder()
        geoCoder.geocodeAddressString(hotel.display_addr, completionHandler: {
            (placemarks, error) -> Void in
            if error != nil {
                println(error)
                return
            }
            
            if placemarks != nil && placemarks.count > 0 {
                let placemark = placemarks[0] as CLPlacemark
                // Add Annotation
                let annotation = MKPointAnnotation()
                annotation.title = self.hotel.name
                annotation.subtitle = self.hotel.poi_addr
                annotation.coordinate = placemark.location.coordinate
                self.mapView.showAnnotations([annotation], animated: true)
                self.mapView.selectAnnotation(annotation, animated: true)
            }
        })
        title = self.hotel.name
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
