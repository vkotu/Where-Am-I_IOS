//
//  ViewController.swift
//  Where-Am-I?
//
//  Created by Venkat Kotu on 2/9/16.
//  Copyright © 2016 VenkatKotu. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation


class ViewController: UIViewController, CLLocationManagerDelegate {
    
    var manager: CLLocationManager!

    @IBOutlet weak var lonLabel: UILabel!

    @IBOutlet weak var latLabel: UILabel!
    
    @IBOutlet weak var courseLabel: UILabel!
    
    @IBOutlet weak var speed: UILabel!
    
    
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var altitude: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        manager = CLLocationManager()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
  
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print(locations)
        var userLocation: CLLocation  = locations[0] as! CLLocation
        var latitude = userLocation.coordinate.latitude
        var longitude = userLocation.coordinate.longitude
        self.latLabel.text = "\(latitude)"
        self.lonLabel.text = "\(longitude)"
        self.courseLabel.text = "\(userLocation.course)"
        self.speed.text = "\(userLocation.speed)"
        self.altitude.text = "\(userLocation.altitude)"
        
        
        CLGeocoder().reverseGeocodeLocation(userLocation, completionHandler: {(placemarks,error) in
            if (error != nil) {
                print(error)
            }else{
                if let p: CLPlacemark! = CLPlacemark(placemark: placemarks![0] ) {
                    var subThorughFare:String = ""
                    if(p.subThoroughfare != nil)  {
                        subThorughFare = p.subThoroughfare!
                    }
                    self.address.text = "\(subThorughFare) \(p.thoroughfare!) \n \(p.subLocality!) \n \(p.subAdministrativeArea!) \n \(p.postalCode!) \n \(p.country!)"
                    //print(p)
                }
            }
        })
    }

}



