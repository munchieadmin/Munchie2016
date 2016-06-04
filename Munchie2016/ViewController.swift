//
//  ViewController.swift
//  Munchie2016
//
//  Created by Corbin Benally on 5/22/16.
//  Copyright © 2016 Munchie Meets. All rights reserved.
//

import UIKit

class LasVegasNightclub_details: NSObject{
    //Object strings
    var name: String!
    var objectId: String?
    var address: String?
    var hours: String?
    
//    override var name: String? {
//        get { return super.text }
//        
//        set(v){  super.text = v }
//    }
    
}


class TableViewController: UITableViewController {
    //Create Backendless instance
    var backendless = Backendless.sharedInstance()
    
    //Create array to save backendless object strings
    var arrayOfNightclubs: [String?] = []
    
    @IBOutlet weak var stringLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        //
        tableView.reloadData()
        fetchingNightclubDetails()
        
        
    }

    
    
    func fetchingNightclubDetails() {
        
        print("\n============ Fetching first page using the ASYNC API ============")
        
        let startTime = NSDate()
        let query = BackendlessDataQuery()
        
        backendless.persistenceService.of(LasVegasNightclub_details.ofClass()).find(
            query,
            response: { (results : BackendlessCollection!) -> () in
                
                let currentPage = results.getCurrentPage()
                print("Loaded \(currentPage.count) nightclub objects")
                for result in currentPage as! [LasVegasNightclub_details] {
                    print("Nightclub name = \(result.name)")
                    for i in 1...18 {
                    //self.arrayOfNightclubs.insert("\(result.name)", atIndex: i)
                        self.arrayOfNightclubs.append("\(result.name!)")
                        self.stringLabel?.text = "\(result.name)"
                    }
                    
                }
                
                print("Total time (ms) - \(1000*NSDate().timeIntervalSinceDate(startTime))")
                
            },
            
            error: { ( fault : Fault!) -> () in
                print("Server reported an error: \(fault)")
            }
        )
    }
    
    
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }


    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("Cell") as UITableViewCell!
        
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCellStyle.Value1, reuseIdentifier: "Cell")
        }
        
        cell.textLabel?.text = arrayOfNightclubs[indexPath.row]
        //cell.textLabel?.text = "Corbin Test"


        return cell
    }
    
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
    return arrayOfNightclubs.count
    }

}

