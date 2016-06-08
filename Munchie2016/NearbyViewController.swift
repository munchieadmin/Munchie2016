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

class NearbyViewController: UIViewController {
    //Create Backendless instance
    var backendless = Backendless.sharedInstance()
    
    //Create array to save backendless object strings
    //var arrayOfNightclubs: [String?] = []
    var locationsOfNightclubs:Array< String > = Array < String >()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadGeoPointsAsync()
        
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    
    func loadGeoPointsAsync() {
        
        print("\n============ Loading geo points with the ASYNC API ============")
        
        let query = BackendlessGeoQuery()
        query.addCategory("geoservice_sample")
        query.includeMeta = true
        
        backendless.geoService.getPoints(
            query,
            response: { (var points : BackendlessCollection!) -> () in
                self.nextPageAsync(points)
            },
            error: { (var fault : Fault!) -> () in
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
        }
        
        points.nextPageAsync(
            { (var rest : BackendlessCollection!) -> () in
                self.nextPageAsync(rest)
            },
            error: { (var fault : Fault!) -> () in
                print("Server reported an error: \(fault)")
            }
        )
    }
}