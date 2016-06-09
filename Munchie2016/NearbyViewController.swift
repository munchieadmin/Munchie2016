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
    var latsOfNightclubs:Array<NSNumber> = Array <NSNumber>()
    var longsOfNightclubs:Array<NSNumber> = Array <NSNumber>()
    
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
        
        //get lat and long
        let nightclubLatitude = latsOfNightclubs
        let nightclubLongitude = longsOfNightclubs
        let nightclubCoord2D  = CLLocationCoordinate2D(latitude: nightclubLatitude as Double , longitude: nightclubLongitude as Double)
        
        //set view span
        //center map at this region
        //add annotation
        
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