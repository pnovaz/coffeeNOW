//
//  SignUpViewController.swift
//  coffeeNOW
//
//  Created by Petra Novakovic on 4/14/17.
//  Copyright © 2017 Apple Inc. All rights reserved.
//

import UIKit
import Parse

class SignUpViewController: UIViewController {
    
    
    @IBOutlet weak var emailField: UITextField!
    
    @IBOutlet weak var usernameField: UITextField!
    
    @IBOutlet weak var passwordField: UITextField!
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    
    //************************************************************************
    //ALL PERMANENT DATA IS STORED IN BACK4APP.COM USING PARSE CLOUD SERVER

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
        self.usernameField.resignFirstResponder()
        self.passwordField.resignFirstResponder()
        self.emailField.resignFirstResponder()
        
    }
    
    
    @IBAction func signUp(_ sender: Any) {
        let username = self.usernameField.text
        let password = self.passwordField.text
        let email = self.emailField.text
        
       
            // Run a spinner to show a task in progress
        
        self.spinner.startAnimating()
            
        
        
        let newUser = PFUser()
        
        newUser.username = username
        newUser.password = password
        newUser.email = email
        
        // Sign up the user asynchronously
        newUser.signUpInBackground(block: { (succeed, error) -> Void in
            
            // Stop the spinner
            self.spinner.stopAnimating()
            if ((error) != nil) {
                let alert = UIAlertView(title: "Error", message: "\(error)", delegate: self, cancelButtonTitle: "OK")
                alert.show()
                
            } else {
                let alert = UIAlertView(title: "Success", message: "Signed Up", delegate: self, cancelButtonTitle: "OK")
                alert.show()
            
        
            }

})
}
}

