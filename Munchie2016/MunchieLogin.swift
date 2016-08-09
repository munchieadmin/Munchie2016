//
//  MunchieLogin.swift
//  Munchie2016
//
//  Created by Ricky Didaravong on 6/1/16.
//  Copyright © 2016 Munchie Meets. All rights reserved.
//

import UIKit

class MunchieLogin: UIViewController {
    var backendless = Backendless.sharedInstance()
    
    @IBOutlet weak var userEmailAddress: UITextField!
    @IBOutlet weak var userPassword: UITextField!
    
    
    @IBAction func SignUp(sender: UIButton) {
        
    }
    
    
    @IBAction func LogIn(sender: AnyObject) {
        
        userLoginSync(userEmailAddress, userPass: userPassword)
        
        //        self.performSegueWithIdentifier(
        //"loginSuccess", sender: self)
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //backendless.initApp(APP_ID, secret:SECRET_KEY, version:VERSION_NUM)
        
        dismissViewControllerAnimated(true, completion:nil)
        
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func userLoginSync(userEmail: UITextField!, userPass: UITextField!) {
        //func userLoginSync() {
        // - sync methods with fault as exception (full "try/catch/finally" version)
        Types.tryblock({ () -> Void in
            // - user login
            var user = self.backendless.userService.login(userEmail.text, password: userPass.text)
            NSLog("LOGINED USER: %@", user.description)
            
            
            // - user update
            let counter: AnyObject! = user.getProperty("counter")
            user.setProperty("counter", object: counter)
            user = self.backendless.userService.update(user)
            NSLog("UPDATED USER: %@", user.description)
            
            }, catchblock: { (exception) -> Void in
                NSLog("FAULT: %@", exception as! Fault)
            },
               finally: { () -> Void in
                NSLog("USER OPERATIONS ARE FINISHED")
        })
        
        
    }
    
}
