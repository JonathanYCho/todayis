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

extension Date {
    func toString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM d"
        print(dateFormatter.string(from: self))
        return dateFormatter.string(from: self)
    }
}


class ViewController: UIViewController {
    var locationManager: CLLocationManager?
    var startLocation: CLLocation?
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var celebrationLabel: UILabel!
    @IBOutlet weak var map: MKMapView!
    
    var today = Date()
    func displayDate(){
        dateLabel.text = String(describing: today.toString())
    }
    @IBAction func dateNext(_ sender: UIButton) {
        let tomorrow = Calendar.current.date(byAdding: .day, value: 1, to: today)
        today = tomorrow!
        displayDate()
    }
    
    @IBAction func datePrev(_ sender: UIButton) {
        let yesterday = Calendar.current.date(byAdding: .day, value: -1, to: today)
        today = yesterday!
        displayDate()
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
//        var myLocation = locationManager?.requestLocation()
        
        
        let centerLocation = CLLocationCoordinate2DMake(-27 , 153)
        let mapSpan = MKCoordinateSpanMake(0.01, 0.01)
        let mapRegion = MKCoordinateRegionMake(centerLocation, mapSpan)
        self.map.setRegion(mapRegion, animated: true)
        self.map.userTrackingMode = .follow
        // Do any additional setup after loading the view, typically from a nib.
        
        
        //TODO REAL LOCATION
        let mainLoc = CLLocationCoordinate2DMake(37.331648, -122.032624)
        let dropPin = MKPointAnnotation()
        dropPin.coordinate = mainLoc
        
        //TODO: TITLE
        dropPin.title = "Bagels"
        map.addAnnotation(dropPin)
        
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
