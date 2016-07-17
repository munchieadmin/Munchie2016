//
//  SignUpViewController.swift
//  Munchie2016
//
//  Created by Corbin Benally on 7/16/16.
//  Copyright © 2016 Munchie Meets. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {

    //text field outlets connected to the storyboard
    @IBOutlet weak var signUpEmail: UITextField!
    @IBOutlet weak var signUpPassword: UITextField!
    @IBOutlet weak var signUpFirstName: UITextField!
    @IBOutlet weak var signUpLastName: UITextField!
    @IBOutlet weak var signUpDateOfBirth: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    //action button which clears any populated text in the displayed text fields
    @IBAction func clearTextFields(sender: AnyObject) {
        signUpEmail.text = ""
        signUpPassword.text = ""
        signUpFirstName.text = ""
        signUpLastName.text = ""
        signUpDateOfBirth.text = ""
        
    }
    
    
    @IBAction func submitUserRegistration(sender: AnyObject) {
        //Calls Backendless registration call
        registerUserAsync()
    
    }
    
    
    
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //asynchronous registration call provided by Backendless
    func registerUserAsync() {
        
        let user = BackendlessUser()
        user.email = signUpEmail.text
        user.password = signUpPassword.text
        
        backendless.userService.registering(user,
                                            response: { (registeredUser : BackendlessUser!) -> () in
                                                print("User has been registered (ASYNC): \(registeredUser)")
            },
                                            error: { ( fault : Fault!) -> () in
                                                print("Server reported an error: \(fault)")
            } 
        ) 
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
