//
//  NearbyViewController.swift
//  
//
//  Created by Corbin Benally on 6/7/16.
//
//

import Foundation
import UIKit
import MapKit

class NearbyViewController: UIViewController, CLLocationManagerDelegate {
    //Create Backendless instance
    var backendless = Backendless.sharedInstance()
    
    //Create array to save backendless object strings
    //var arrayOfNightclubs: [String?] = []

    //var latsOfNightclubs: [Double] = []
    //var longsOfNightclubs: [Double] = []
    var latsOfNightclubs:Array<NSNumber> = Array <NSNumber>()
    var longsOfNightclubs:Array<NSNumber> = Array <NSNumber>()

    //var latsOfNightclubs: [Double] = []
    //var longsOfNightclubs: [Double] = []
    //var latsOfNightclubs:Array<NSNumber> = Array <NSNumber>()
    //var longsOfNightclubs:Array<NSNumber> = Array <NSNumber>()

    
    @IBOutlet weak var myMapView: MKMapView!
    let myLocationManager = CLLocationManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myLocationManager.desiredAccuracy = kCLLocationAccuracyBest
        myLocationManager.requestWhenInUseAuthorization()
        myLocationManager.startUpdatingLocation()
        myLocationManager.delegate = self
        
        loadGeoPointsAsync()
        
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        //get most recent coordinate
        let myCoordinate = locations[locations.count - 1]
        
        //create double to convert
        
        //get lat and long

        //let nightclubLatitude = Double(self.latsOfNightclubs)

        //let nightclubLongitude = longsOfNightclubs

//        let nightclubLatitude = latsOfNightclubs
//        let nightclubLongitude = longsOfNightclubs
//        let nightclubCoord2D  = CLLocationCoordinate2D(latitude: nightclubLatitude as Double , longitude: nightclubLongitude as Double)
        
        let myLat = myCoordinate.coordinate.latitude
        let myLong = myCoordinate.coordinate.longitude
        let myCoor2D = CLLocationCoordinate2D(latitude: myLat, longitude: myLong)
        //let nightclubLatitude = Double(self.latsOfNightclubs)

        //let nightclubLongitude = longsOfNightclubs
        //let nightclubLatitude = Double(self.latsOfNightclubs)

        //let nightclubLongitude = longsOfNightclubs

        
        //var latDouble:Double
        
        
        //latDouble = nightclubLatitude as Double
        
        
        

        //let nightclubCoord2D  = CLLocationCoordinate2D(latitude: nightclubLatitude, longitude: nightclubLongitude)

        //let nightclubCoord2D  = CLLocationCoordinate2D(latitude: nightclubLatitude, longitude: nightclubLongitude)

        //let nightclubCoord2D  = CLLocationCoordinate2D(latitude: nightclubLatitude, longitude: nightclubLongitude)

        //set view span
        let myLatDelta = 0.05
        let myLongDelta = 0.05
        let mySpan = MKCoordinateSpan(latitudeDelta: myLatDelta, longitudeDelta: myLongDelta)
        
        //center map at this region
        let myRegion = MKCoordinateRegion(center: myCoor2D, span: mySpan)
        myMapView.setRegion(myRegion, animated: true)
        
        //add annotation
        let myAnno = MKPointAnnotation()
        myAnno.coordinate = myCoor2D
        myMapView.addAnnotation(myAnno)
        
        //test to verify
        
    }
    
    
    
    
    
    func loadGeoPointsAsync() {
        
        print("\n============ Loading geo points with the ASYNC API ============")
        
        let query = BackendlessGeoQuery()
        query.addCategory("LVNightclubs")
        query.includeMeta = true
        
        backendless.geoService.getPoints(
            query,
            response: { ( points : BackendlessCollection!) -> () in
                self.nextPageAsync(points)
            },
            error: { (fault : Fault!) -> () in
                print("Server reported an error: \(fault)")
            }
        )
    }
    
    func nextPageAsync(points: BackendlessCollection) {
        
        if points.getCurrentPage().count == 0 {
            return
        }
        
        let geoPoints = points.getCurrentPage() as! [GeoPoint]
        for geoPoint in geoPoints {
            print("\(geoPoint)")
            self.latsOfNightclubs.append(geoPoint.latitude)
            self.longsOfNightclubs.append(geoPoint.longitude)
            
        }
        
        points.nextPageAsync(
            { (rest : BackendlessCollection!) -> () in
                self.nextPageAsync(rest)
            },
            error: { (fault : Fault!) -> () in
                print("Server reported an error: \(fault)")
            }
        )
    }
}