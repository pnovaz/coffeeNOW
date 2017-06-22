//
//  ViewController.swift
//  coffeeNOW
//
//  Created by Petra Novakovic on 3/18/17.
//  Copyright © 2017 Apple Inc. All rights reserved.
//

import UIKit
import Parse

class ViewController: UIViewController, UITabBarDelegate {
    
   
    @IBOutlet weak var userNameLabel1: UILabel!
    
  
    //************************************************************************
    //ALL PERMANENT DATA IS STORED IN BACK4APP.COM USING PARSE CLOUD SERVER


    override func viewDidLoad() {
        
        // Show the current visitor's username
       
     
        }

    
    override func viewWillAppear(_ animated: Bool) {
          
            //greet the user
        
            if let pUserName = PFUser.current()?["username"] as? String {
                self.userNameLabel1.text = "Hi, " + pUserName + "!"
                
                
                super.viewWillAppear(animated)
                
                }
                
                
      
            }
        

}
