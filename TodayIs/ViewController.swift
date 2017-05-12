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
    var Days: [String: Array<String>] = [
        "May 1":["May Day","Law Day","National Loyalty Day","National Chocolate Parfait Day","National Mother Goose Day","Silver Star Service Banner Day","National Melanoma MonDay","School Principals' Day"],
        "May 2":["National Foster Care Day","National Life Insurance Day","National Truffle Day"],
        "May 3":["National SAN Architect Day","National Textiles Day","National Chocolate Custard Day","National Garden Meditation Day","National Lumpy Rug Day","National Paranormal Day", "National Raspberry Popover Day","National Specially-Abled Pets Day","National Two Different Colored Shoes Day"],
        "May 4":["Bird Day","National Candied Orange Peel Day","National Orange Juice Day","World Password Day","National Renewal Day","National Star Wars Day","National Weather Observers Day","National Day of Prayer","National Day of Reason"],
        "May 5":["National Astronaut Day","Cinco de Mayo","National Hoagie Day","National Totally Chipotle Day","National Space Day","School Lunch Hero Day"],
        "May 6":["National Beverage Day","National Crepe Suzette Day","National Homebrew Day","National Nurses Day","Join Hands Day","National Bombshells' Day","National Scrapbook Day","National Start Seeing Monarchs Day","National Train Day","Free Comic Book Day"],
        "May 7":["National Barrier Awareness Day","National Infertility Survival Day","National Packaging Design Day","National Paste-Up Day","National Roast Leg of Lamb Day","National Lemonade Day"],
        "May 8":["National Coconut Cream Pie Day","National Have A Coke Day","National Student Nurse Day","National Women's Checkup Day"],
        "May 9":["National Sleepover Day","National Butterscotch Brownie Day","National Lost Sock Memorial Day","National Moscato Day","National Teacher Appreciation Day"],
        "May 10":["National Lipid Day","National Shrimp Day","National Clean Up Your Room Day","National Bike to School Day","National School Nurse Day","National Receptionists' Day","National Third Shift Workers Day"],
        "May 11":["National Foam Rolling Day","National Twilight Zone Day","National Eat What You Want Day"],
        "May 12":["National Fibromyalgia Awareness Day","National Limerick Day","National Nutty Fudge Day","National Odometer Day","National Military Spouse Appreciation Day","National Provider Appreciation Day"],
        "May 13":["National Crouton Day","National Apple Pie Day","National Frog Jumping Day","National Fruit Cocktail Day","National Babysitter's Day","National Birth Mother's Day","National Archery Day","National Cornelia De Lange Syndrome Awareness Day","National Miniature Golf Day","National Stamp Out Hunger Food Drive Day"],
        "May 14":["National Buttermilk Biscuit Day","National Dance Like a Chicken Day","National Underground America Day","Mother's Day"],
        "May 15":["National Chocolate Chip Day","National Nylon Stocking Day","Peace Officers Memorial Day"],
        "May 16":["Honor Our LGBT Elders Day","National Biographer’s Day","National Coquilles Saint Jacques Day","National Love a Tree Day","National Piercing Day","National Sea Monkey Day"],
        "May 17":["National Cherry Cobbler Day","National Pack Rat Day","National Walnut Day"],
        "May 18":["National Cheese Souffle Day","National HIV Vaccine Awareness Day","National No Dirty Dishes Day","National Visit Your Relatives Day"],
        "May 19":["National Devil’s Food Cake Day","National May Ray Day","National Bike to Work Day","National Defense Transportation Day","National Endangered Species Day","National Pizza Party Day","NASCAR Day"],
        "May 20":["National Be a Millionaire Day","National Pick Strawberries Day","National Quiche Lorraine Day","National Armed Forces Day","National Learn to Swim Day"],
        "May 21":["National Take Your Parents to the Playground Day","National American Red Cross Founder’s Day","National Memo Day","National Strawberries and Cream Day","National Waitstaff Day"],
        "May 22":["National Buy a Musical Instrument Day","National Maritime Day","National Vanilla Pudding Day"],
        "May 23":["National Lucky Penny Day","National Taffy Day"],
        "May 24":["National Escargot Day","Aviation Maintenance Technician Day","Emergency Medical Services for Children","Brother's Day"],
        "May 25":["National Brown-Bag It Day","National Missing Children’s Day","Red Nose Day","National Tap Dance Day","National Wine Day","Towel Day"],
        "May 26":["National Blueberry Cheesecake Day","National Don't Fry Day","National Heat Awareness Day"],
        "May 27":["National Cellophane Tape Day","National Grape Popsicle Day"],
        "May 28":["National Brisket Day","National Hamburger Day"],
        "May 29":["National Coq Au Vin Day","National Paperclip Day","Memorial Day"],
        "May 30":["Loomis Day","National Hole In My Bucket Day","National Mint Julep Day","National Water a Flower Day"],
        "May 31":["National Autonomous Vehicle Day","National Macaroon Day","National Save Your Hearing Day","National Speak in Sentences Day","National Senior Health and Fitness Day"]]
    var celebrationMarker = 0
    var today = Date()
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var celebrationLabel: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    var resultSearchController:UISearchController? = nil
    let locationManager = CLLocationManager()
    var selectedPin:MKPlacemark? = nil  //caches any incoming placemarks

    func displayCelebration(){
        celebrationLabel.text = Days[today.toString()]?[celebrationMarker]
    }
    
    func displayDate(){
        dateLabel.text = today.toString()
        displayCelebration()
    }
    @IBAction func dateNext(_ sender: UIButton) {
        let tomorrow = Calendar.current.date(byAdding: .day, value: 1, to: today)
        today = tomorrow!
        celebrationMarker = 0
        displayDate()
    }
    
    @IBAction func datePrev(_ sender: UIButton) {
        let yesterday = Calendar.current.date(byAdding: .day, value: -1, to: today)
        today = yesterday!
        celebrationMarker = 0
        displayDate()
    }
    
    @IBAction func celebrationNext(_ sender: UIButton) {
        celebrationMarker += 1
        if(celebrationMarker >= Days[today.toString()]!.count){
            celebrationMarker = 0
        }
        displayCelebration()
    }
    
    @IBAction func celebrationPrev(_ sender: UIButton) {
        celebrationMarker -= 1
        if(celebrationMarker < 0){
            celebrationMarker = (Days[today.toString()]!.count-1)
        }
        displayCelebration()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        displayDate()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        
        //      set-up the search results table:
        let locationSearchTable = storyboard!.instantiateViewController(withIdentifier: "LocationSearchTable") as! LocationSearchTable
        resultSearchController = UISearchController(searchResultsController: locationSearchTable)
        resultSearchController?.searchResultsUpdater = locationSearchTable
        
        //      passes along a handle of the mapView from the main View Controller onto the locationSearchTable
        locationSearchTable.mapView = mapView
        
        //      set up the search bar, configures it and embeds it within the navigation bar
        let searchBar = resultSearchController!.searchBar
        searchBar.sizeToFit()
        searchBar.placeholder = "find Nutty Fudge near you"
        navigationItem.titleView = resultSearchController?.searchBar
        
        //      configure the UISearchController's appearance
        resultSearchController?.hidesNavigationBarDuringPresentation = false
        resultSearchController?.dimsBackgroundDuringPresentation = true
        definesPresentationContext = true
        
        //      The parent (ViewController) passes a handle of itself to the child controller (LocationSearchTable)
        locationSearchTable.handleMapSearchDelegate = self
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // an API call that launches the Apple Maps app with driving directions. You convert the cached selectedPin to a MKMapItem. The Map Item is then able to open up driving directions in Apple Maps using the openInMapsWithLaunchOptions() method
    func getDirections(){
        if let selectedPin = selectedPin {
            let mapItem = MKMapItem(placemark: selectedPin)
            let launchOptions = [MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeDriving]
            mapItem.openInMaps(launchOptions: launchOptions)
        }
    }

}

extension ViewController : CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            locationManager.requestLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            let span = MKCoordinateSpanMake(0.05, 0.05)
            let region = MKCoordinateRegionMake(location.coordinate, span)
            mapView.setRegion(region, animated: true)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: NSError) {
        print("error:: \(error)")
    }
}

//  implements the dropPinZoomIn() method in order to adopt the HandleMapSearch protocol.
extension ViewController: HandleMapSearch {
    func dropPinZoomIn(placemark:MKPlacemark){
        // cache the pin
        selectedPin = placemark
        // clear existing pins
        mapView.removeAnnotations(mapView.annotations)
        // populate the map pin with information
        let annotation = MKPointAnnotation()
        annotation.coordinate = placemark.coordinate
        annotation.title = placemark.name
        if let city = placemark.locality,
            let state = placemark.administrativeArea {
            annotation.subtitle = "\(city) \(state)"
        }
        mapView.addAnnotation(annotation)  //adds annotation to the map
        let span = MKCoordinateSpanMake(0.05, 0.05)
        let region = MKCoordinateRegionMake(placemark.coordinate, span)
        mapView.setRegion(region, animated: true)  //zooms the map to the coordinate
        print ("This is the target location: \(mapView.centerCoordinate.latitude)")
    }
}



// customize the map pin callout with a button that takes you to Apple Maps for driving directions
extension ViewController : MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation {
            // return nil so you don't interfere with the user's blue location dot
            return nil
        }
        let reuseId = "pin" // reuse identifier for the pin
        // setting the map pin UI, along with the color and callout
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MKPinAnnotationView
        pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
        pinView?.pinTintColor = UIColor.orange
        pinView?.canShowCallout = true
        let smallSquare = CGSize(width: 30, height: 30)
        let button = UIButton(frame: CGRect(origin: CGPoint(x: 0,y :0), size: smallSquare))
        button.setBackgroundImage(#imageLiteral(resourceName: "car"), for: .normal)
        button.addTarget(self, action: #selector(ViewController.getDirections), for: .touchUpInside)
        // set to an UIButton that you instantiate programmatically. The button is set to a size of 30×30. The button image is set to an asset catalog image named car, and the button’s action is wired to a custom method called getDirections()
        pinView?.leftCalloutAccessoryView = button
        return pinView
    }
}



