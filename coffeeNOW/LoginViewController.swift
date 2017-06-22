//
//  LoginViewController.swift
//  coffeeNOW
//
//  Created by Petra Novakovic on 4/14/17.
//  Copyright © 2017 Apple Inc. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    @IBOutlet weak var usernameField: UITextField!
    
    @IBOutlet weak var passwordField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        spinner.isHidden = true

        
    }
    //************************************************************************
    //ALL PERMANENT DATA IS STORED IN BACK4APP.COM USING PARSE CLOUD SERVER


    
    @IBAction func login(_ sender: Any) {
       
        let username = self.usernameField.text
        
        let password = self.passwordField.text
    
        
        spinner.startAnimating()
        
//send request to log in
        PFUser.logInWithUsername(inBackground: username!, password: password!, block: { (user, error) -> Void in
            
         self.spinner.stopAnimating()
        
            if ((user) != nil) {
                var alert = UIAlertView(title: "Success", message: "Logged In", delegate: self, cancelButtonTitle: "OK")
                alert.show()
                
                           }
            else
            {
                var alert = UIAlertView(title: "Error", message: "\(error)", delegate: self, cancelButtonTitle: "OK")
                alert.show()
            }
        
    })
    
    /*
    
        let vc = storyboard?.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        
        
      let profile = storyboard? .instantiateViewController(withIdentifier: "profileViewController") as! profileViewController
        */
        
    }
    
       
            
   
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
        self.usernameField.resignFirstResponder()
        self.passwordField.resignFirstResponder()
        
    }

    
    
    
    
    @IBAction func forgotPassword(_ sender: Any) {
        
        let email = kSecMatchEmailAddressIfPresent
        
        
        // Send a request to reset a password
        PFUser.requestPasswordResetForEmail(inBackground: email as String)
        
        let alert = UIAlertController (title: "Password Reset", message: "An email containing information on how to reset your password has been sent to " + (email as String) + ".", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
        
    }



    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    }
