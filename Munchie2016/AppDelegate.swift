//
//  AppDelegate.swift
//  Munchie2016
//
//  Created by Corbin Benally on 5/22/16.
//  Copyright © 2016 Munchie Meets. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    //Secret Keys from Backendless
    let APP_ID = "AA9D0225-3DF1-DC0F-FF91-2B1E67968100"
    let SECRET_KEY = "3CF6B0FE-103B-3F22-FF4E-5671000E6900"
    let VERSION_NUM = "v1"

    var window: UIWindow?
    
    //Creating an instance which can be shared once initialized
    var backendless = Backendless.sharedInstance()


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {

        //Initializing the Backendless APP to the server with public & private keys
        backendless.initApp(APP_ID, secret:SECRET_KEY, version:VERSION_NUM)
        
        
        
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

