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
    
    var latsOfNightclubs:Array<GeoPoint> = Array <GeoPoint>()
    var longsOfNightclubs:Array<GeoPoint> = Array <GeoPoint>()
    
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
        let myLat = myCoordinate.coordinate.latitude
        let myLong = myCoordinate.coordinate.longitude
        let myCoor2D = CLLocationCoordinate2D(latitude: myLat, longitude: myLong)
        
        //let clubLat = Double(latsOfNightclubs[0].latitude)
        //let clubLong = Double(longsOfNightclubs[0].longitude)
        //let clubCoord2D = CLLocationCoordinate2D(latitude: clubLat, longitude: clubLong)

        //set view span
        let myLatDelta = 0.05
        let myLongDelta = 0.05
        let mySpan = MKCoordinateSpan(latitudeDelta: myLatDelta, longitudeDelta: myLongDelta)
        
        //club span
        //let clubSpan = MKCoordinateSpan(latitudeDelta: clubLat, longitudeDelta: clubLong)
        
        //center map at this region
        let myRegion = MKCoordinateRegion(center: myCoor2D, span: mySpan)
        //myMapView.setRegion(myRegion, animated: true)
        
        //let clubRegion = MKCoordinateRegion(center: clubCoord2D, span: clubSpan)
        myMapView.setRegion(myRegion, animated: true)
        
        
        //add annotation
        let myAnno = MKPointAnnotation()
        myAnno.coordinate = myCoor2D
        
        let clubAnno = MKPointAnnotation()
        //clubAnno.coordinate = clubCoord2D
        
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
            self.latsOfNightclubs.append(geoPoint)
            self.longsOfNightclubs.append(geoPoint)
            
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