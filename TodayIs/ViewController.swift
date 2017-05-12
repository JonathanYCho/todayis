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
//    var Days: [String:[String]] = [
//        "May 1":["May Day","Law Day","National Loyalty Day","National Chocolate Parfait Day","National Mother Goose Day","Silver Star Service Banner Day","National Melanoma MonDay","School Principals&#8217; Day"],
//        "May 2":["National Foster Care Day","National Life Insurance Day","National Truffle Day"],
//        "May 3":["National SAN Architect Day","National Textiles Day","National Chocolate Custard Day","National Garden Meditation Day","National Lumpy Rug Day","National Paranormal Day", "National Raspberry Popover Day","National Specially-Abled Pets Day","National Two Different Colored Shoes Day"],
//        "May 4":["Bird Day","National Candied Orange Peel Day","National Orange Juice Day","World Password Day","National Renewal Day","National Star Wars Day","National Weather Observers Day","National Day of Prayer","National Day of Reason"],
//        "May 5":["National Astronaut Day","Cinco de Mayo","National Hoagie Day","National Totally Chipotle Day","National Space Day","School Lunch Hero Day"],
//        "May 6":["National Beverage Day","National Crepe Suzette Day","National Homebrew Day","National Nurses Day","Join Hands Day","National Bombshells&#8217; Day","National Scrapbook Day","May 6":"National Start Seeing Monarchs Day","May 6":"National Train Day","May 6":"Free Comic Book Day","May 7":"National Barrier Awareness Day","May 7":"National Infertility Survival Day","May 7":"National Packaging Design Day","May 7":"National Paste-Up Day","May 7":"National Roast Leg of Lamb Day","May 7":"National Lemonade Day","May 8":"National Coconut Cream Pie Day","May 8":"National Have A Coke Day","May 8":"National Student Nurse Day","May 8":"National Women&#8217;s Checkup Day","May 9":"National Sleepover Day","May 9":"National Butterscotch Brownie Day","May 9":"National Lost Sock Memorial Day","May 9":"National Moscato Day","May 9":"National Teacher Appreciation Day", "May 10":"National Lipid Day","May 10":"National Shrimp Day","May 10":"National Clean Up Your Room Day","May 10":"National Bike to School Day","May 10":"National School Nurse Day","May 10":"National Receptionists&#8217; Day","May 10":"National Third Shift Workers Day","May 11":"National Foam Rolling Day","May 11":"National Twilight Zone Day","May 11":"National Eat What You Want Day","May 12":"National Fibromyalgia Awareness Day","May 12":"National Limerick Day","May 12":"National Nutty Fudge Day","May 12":"National Odometer Day","May 12":"National Military Spouse Appreciation Day","May 12":"National Provider Appreciation Day","May 13":"National Crouton Day","May 13":"National Apple Pie Day","May 13":"National Frog Jumping Day","May 13":"National Fruit Cocktail Day","May 13":"National Babysitter&#8217;s Day", "May 13":"National Birth Mother&#8217;s Day","May 13":"National Archery Day","May 13":"National Cornelia De Lange Syndrome Awareness Day","May 13":"National Miniature Golf Day","May 13":"National Stamp Out Hunger Food Drive Day","May 14":"National Buttermilk Biscuit Day","May 14":"National Dance Like a Chicken Day","May 14":"National Underground America Day","May 14":"Mother&#8217;s Day","May 15":"National Chocolate Chip Day","May 15":"National Nylon Stocking Day","May 15":"Peace Officers Memorial Day","May 16":"Honor Our LGBT Elders Day","May 16":"National Biographer’s Day","May 16":"National Coquilles Saint Jacques Day","May 16":"National Love a Tree Day","May 16":"National Piercing Day","May 16":"National Sea Monkey Day","May 17":"National Cherry Cobbler Day","May 17":"National Pack Rat Day","May 17":"National Walnut Day","May 18":"National Cheese Souffle Day","May 18":"National HIV Vaccine Awareness Day","May 18":"National No Dirty Dishes Day","May 18":"National Visit Your Relatives Day","May 19":"National Devil’s Food Cake Day","May 19":"National May Ray Day","May 19":"National Bike to Work Day","May 19":"National Defense Transportation Day","May 19":"National Endangered Species Day","May 19":"National Pizza Party Day","May 19":"NASCAR Day","May 20":"National Be a Millionaire Day","May 20":"National Pick Strawberries Day","May 20":"National Quiche Lorraine Day","May 20":"National Armed Forces Day","May 20":"National Learn to Swim Day","May 21":"National Take Your Parents to the Playground Day","May 21":"National American Red Cross Founder’s Day","May 21":"National Memo Day","May 21":"National Strawberries and Cream Day","May 21":"National Waitstaff Day","May 22":"National Buy a Musical Instrument Day","May 22":"National Maritime Day","May 22":"National Vanilla Pudding Day","May 23":"National Lucky Penny Day","May 23":"National Taffy Day","May 24":"National Escargot Day","May 24":"Aviation Maintenance Technician Day","May 24":"Emergency Medical Services for Children","May 24":"Brother&#8217;s Day","May 25":"National Brown-Bag It Day","May 25":"National Missing Children’s Day","May 25":"Red Nose Day","May 25":"National Tap Dance Day","May 25":"National Wine Day","May 25":"Towel Day","May 26":"National Blueberry Cheesecake Day","May 26":"National Don&#8217;t Fry Day","May 26":"National Heat Awareness Day","May 27":"National Cellophane Tape Day","May 27":"National Grape Popsicle Day","May 28":"National Brisket Day","May 28":"National Hamburger Day","May 29":"National Coq Au Vin Day","May 29":"National Paperclip Day","May 29":"Memorial Day", "May 30":"Loomis Day","May 30":"National Hole In My Bucket Day","May 30":"National Mint Julep Day","May 30":"National Water a Flower Day","May 31":"National Autonomous Vehicle Day","May 31":"National Macaroon Day","May 31":"National Save Your Hearing Day","May 31":"National Speak in Sentences Day","May 31":"National Senior Health and Fitness Day"]
    
    
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
        
        displayDate()
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
