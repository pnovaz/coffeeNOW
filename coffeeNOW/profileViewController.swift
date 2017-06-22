//
//  profileViewController.swift
//  coffeeNOW
//
//  Created by Petra Novakovic on 4/14/17.
//  Copyright © 2017 Apple Inc. All rights reserved.
//

import UIKit
import Parse

class profileViewController: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var selectedImage: UIImageView!
    
    @IBOutlet weak var userNameLabel2: UILabel!
 
    
    var myArray: [String] = []
   
    
    @IBOutlet weak var favoritesTable: UITableView!
//************************************************************************
  //ALL PERMANENT DATA IS STORED IN BACK4APP.COM USING PARSE CLOUD SERVER

    
   
    
    
    
    
    
    let photoPicker = UIImagePickerController()
   
    override func viewDidLoad() {
     
   favoritesTable.dataSource = self

   
       
        print("User favorites:")
        //print user favorites to the screen
        
        let user = PFUser.current()?["favorites"] as? NSArray
        
        if user != nil {
            
            for element in user!{
                
                print(element)
                myArray.append(element as! String)
                
            }
            
            for element in myArray {
                
                //favorites.text = favorites.text.appending(element) + "\n"
            }
            
        } else {
            print("User has no favorites.")
        }
        
        

               super.viewDidLoad()
        
    }
    

    
    
    override func viewWillAppear(_ animated: Bool) {
    
        favoritesTable.reloadData()
        if let pImageFile = PFUser.current()?["image"] as? PFFile{
            
            pImageFile.getDataInBackground( block: { (imageData: Data?, error: Error?) -> Void in
                
                var image: UIImage! = UIImage(data: imageData!)!
                
                
               self.selectedImage.image = UIImage(data: imageData!)
                
                
            })
            
        }
    
        
        
        if let pUserName = PFUser.current()?["username"] as? String {
           
            self.userNameLabel2.text = pUserName
        
    
            
        photoPicker.delegate = self
        

        selectedImage.isHidden = false

     
    
        super.viewWillAppear(animated)
        }}
    
   
    
   
    @IBAction func logOut(_ sender: Any) {
        
        // Send a request to log out a user
        PFUser.logOut()
        
        userNameLabel2.text = ""
        //favorites.text = ""
        
        selectedImage.isHidden = true
        
        navigationController?.popToRootViewController(animated: true)
        
        let alert = UIAlertView(title: "Log Out", message: "You have been logged out!", delegate: self, cancelButtonTitle: "OK")
        alert.show()
        
    }
    
    
    
    
    
    @IBAction func choosePic(_ sender: UIButton) {
        
        photoPicker.delegate = self
        
        photoPicker.sourceType = .photoLibrary
    
        self.present(photoPicker, animated: true, completion: nil)
    

    
}


    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String: Any]){
        
        
        picker .dismiss(animated: true, completion: nil)
        
        selectedImage.image=info[UIImagePickerControllerOriginalImage] as? UIImage
        

        let user = PFUser.current()
                
        let pickedImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        
         let imageData = UIImageJPEGRepresentation(pickedImage, 0.05)
        
         let imageFile = PFFile(name:"image.jpg", data:imageData!)
        
        
        
        user?.setObject(imageFile, forKey:"image")
        
        
    
        
        user!.saveInBackground(block: nil)

    }
    
    //number of rows in section
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.myArray.count
    }
    
    
    //number of sections
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    
    //cell for row at index path
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //let searchResult = self.matchingItems[indexPath.row]
        let cell = self.favoritesTable.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        
        
        cell.textLabel?.text = myArray[indexPath.item]
       
        return cell
        
    }
    
   
    
    
    /*
     
    func tableView(_ tableView: UITableView!, didSelectRowAt indexPath: IndexPath!) {
        
        
        // Get Cell Label
        let indexPath = favoritesTable.indexPathForSelectedRow;
        
        
        
        
        let selectedCell = favoritesTable.cellForRow(at: indexPath!) as UITableViewCell!;
        
       
      
        
    }
     
    */
    
    
 }
