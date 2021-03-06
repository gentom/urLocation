//
//  ViewController.swift
//  urLocation
//
//  Created by Morikawa Gento on 2017/09/07.
//  Copyright © 2017年 gentom. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
//import CoreMotion

class ViewController: UIViewController {
    
    //Map
    @IBOutlet weak var map: MKMapView!
    
    var locationManager: CLLocationManager!
    //var motionManager: CMMotionManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //motionManager = CMMotionManager()
        
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = 20.0
        let status = CLLocationManager.authorizationStatus()
        if(status == CLAuthorizationStatus.notDetermined) {
            print("didChangeAuthorizationStatus:\(status)");
            locationManager.requestAlwaysAuthorization()
        }
        
        locationManager.startUpdatingLocation()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}


//Delegate
extension ViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[0]
        let span: MKCoordinateSpan = MKCoordinateSpanMake(0.01,0.01)
        let myLocation: CLLocationCoordinate2D = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude)
        let region:MKCoordinateRegion = MKCoordinateRegionMake(myLocation, span)
        map.setRegion(region, animated: true)
        self.map.showsUserLocation = true
        self.map.setUserTrackingMode(MKUserTrackingMode.followWithHeading, animated: true)
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        print("didChangeAuthorizationStatus");
        var statusStr = "";
        switch (status) {
        case .notDetermined:        statusStr = "NotDetermined"
        case .restricted:           statusStr = "Restricted"
        case .denied:               statusStr = "Denied"
        case .authorized:           statusStr = "Authorized"
        case .authorizedWhenInUse:  statusStr = "AuthorizedWhenInUse"
        }
        print(" CLAuthorizationStatus: \(statusStr)")
    }
}

