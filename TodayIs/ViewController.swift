//
//  ViewController.swift
//  TodayIs
//
//  Created by Jonathan Cho on 5/11/17.
//  Copyright © 2017 Coding Dojo. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class ViewController: UIViewController {
    var locationManager: CLLocationManager?
    var startLocation: CLLocation?
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var celebrationLabel: UILabel!
    @IBOutlet weak var map: MKMapView!

    

    override func viewDidLoad() {
        super.viewDidLoad()
//        let centerLocation = CLLocationCoordinate2DMake(-27, 153)
//        let mapSpan = MKCoordinateSpanMake(0.01, 0.01)
//        let mapRegion = MKCoordinateRegionMake(centerLocation, mapSpan)
//        self.map.setRegion(mapRegion, animated: true)
//        map.userTrackingMode = .follow
        // Do any additional setup after loading the view, typically from a nib.
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.desiredAccuracy = kCLLocationAccuracyBest
        
        locationManager?.requestWhenInUseAuthorization()
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
//I hope I don't accidentally merge the branches anytime soon.
//Red two standing by.
//Stay on target!

extension ViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if startLocation == nil {
            startLocation = locations.first
        } else {
            guard let latest = locations.first else { return }
            let distanceInMeters = startLocation?.distance(from: latest)
            print("distance in meters: \(String(describing: distanceInMeters!))")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedAlways || status == .authorizedWhenInUse {
            locationManager?.startUpdatingLocation()
            locationManager?.allowsBackgroundLocationUpdates = true
        }
    }
    
}
