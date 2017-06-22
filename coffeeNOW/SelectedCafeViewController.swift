//
//  SelectedCafeViewController.swift
//  coffeeNOW
//
//  Created by Petra Novakovic on 3/21/17.
//  Copyright © 2017 Apple Inc. All rights reserved.
//

import UIKit
import Parse

class SelectedCafeViewController: UIViewController, UIWebViewDelegate {

    var favoritesArray: [String] = [String]()
    
    
    
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    var name:String? = nil
    
    var address:String? = nil
    
    var urlAddress:URL? = nil
    
    var descript:String? = nil
    
    @IBOutlet weak var cafeName: UILabel!
    
    @IBOutlet weak var cafeAddress: UILabel!
    
    
    //************************************************************************
    //ALL PERMANENT DATA IS STORED IN BACK4APP.COM USING PARSE CLOUD SERVER

        //if let favoritesArray = PFUser.current()?["favorites"] as? String {
        
        
    @IBAction func addToFavorites(_ sender: Any) {

        
        
        let controller = storyboard?.instantiateViewController(withIdentifier: "profileViewController") as! profileViewController
        
       
        
       
        
        var currentUser = PFUser.current()
        
       
        
        currentUser?.addUniqueObject(name, forKey: "favorites")
    
        currentUser?.saveInBackground()
        
        
        var alert = UIAlertView(title: "Success", message: "Added to Favorites", delegate: self, cancelButtonTitle: "OK")
        
        
        alert.show()
        
    }
    

  


    @IBOutlet weak var webview: UIWebView!
   
    override func viewDidLoad() {
          super.viewDidLoad()
        
        self.webview.delegate = self
        self.webview.scrollView.isScrollEnabled = true
        self.webview.scalesPageToFit = true
      
         cafeName.text = name
        cafeAddress.text = address
        
     
      
 load()
        

        
    }
    
    
    func load(){
    let webURL = urlAddress
    
        if (webURL != nil){
    
            print("url exists, wait while page loads")
            
    let urlRequest = URLRequest(url: webURL!)
    
    
  
    webview.loadRequest(urlRequest)
            


    }
        else{
        print("url does not exist")

    }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

  

}
