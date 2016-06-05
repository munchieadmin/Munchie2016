//
//  TableViewController.swift
//  Munchie2016
//
//  Created by Corbin Benally on 6/4/16.
//  Copyright © 2016 Munchie Meets. All rights reserved.
//

import UIKit

class LasVegasNightclub_details: NSObject{
    //Object strings
    var name: String!
    var objectId: String?
    var address: String?
    var hours: String?
    
}


class TableViewController: UITableViewController {
    //Create Backendless instance
    var backendless = Backendless.sharedInstance()
    
    //Create array to save backendless object strings
    //var arrayOfNightclubs: [String?] = []
    var ArrayOfNightclubs:Array< String > = Array < String >()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //
        //tableView.reloadData()
        tableView.delegate = self
        tableView.dataSource = self
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

                        //self.arrayOfNightclubs.insert("\(result.name)", atIndex: i)
                    
                    if let id = result.name {
                        //Do something you want
                        self.ArrayOfNightclubs.append(result.name)
                        self.do_table_refresh()
                        
                    } else {
                        //Print the error
                        print(result.name)
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
        //var cell = tableView.dequeueReusableCellWithIdentifier("Cell") as UITableViewCell!
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        
        let data = ArrayOfNightclubs[indexPath.row]
        
        
        cell.textLabel?.text = data
        
//        if (data == nil){
//        cell.textLabel?.text = data
//        }
//        else
//        {
//         print("Reaching tableview cell")
//        }
        
        
//        if cell == nil {
//            cell = UITableViewCell(style: UITableViewCellStyle.Value1, reuseIdentifier: "Cell")
//        }
//        
//        cell.textLabel?.text = ArrayOfNightclubs[indexPath.row]
        //cell.textLabel?.text = "Corbin Test"
        
        
        
        
        
        
        return cell
    }
    
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return ArrayOfNightclubs.count
    }
    
    
    func do_table_refresh()
    {
        dispatch_async(dispatch_get_main_queue(), {
            self.tableView.reloadData()
            return
        })
    }

    
}
