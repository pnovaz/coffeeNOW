//
//  mapViewController.swift
//  coffeeNOW
//
//  Created by Petra Novakovic on 3/18/17.
//  Copyright © 2017 Apple Inc. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import Parse



class mapViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, CLLocationManagerDelegate  {
   
 
    @IBOutlet weak var map: MKMapView!
  
    @IBOutlet weak var table: UITableView!

    //************************************************************************
    //ALL PERMANENT DATA IS STORED IN BACK4APP.COM USING PARSE CLOUD SERVER

    var matchingItems:[MKMapItem] = []
    
    var selectedPin:MKPlacemark? = nil
    
    
    //method used to format address 
    
    func parseAddress(selectedItem:MKPlacemark) -> String {
        // put a space between "4" and "Melrose Place"
        let firstSpace = (selectedItem.subThoroughfare != nil && selectedItem.thoroughfare != nil) ? " " : ""
        // put a comma between street and city/state
        let comma = (selectedItem.subThoroughfare != nil || selectedItem.thoroughfare != nil) && (selectedItem.subAdministrativeArea != nil || selectedItem.administrativeArea != nil) ? ", " : ""
        // put a space between "Washington" and "DC"
        let secondSpace = (selectedItem.subAdministrativeArea != nil && selectedItem.administrativeArea != nil) ? " " : ""
        let addressLine = String(
            format:"%@%@%@%@%@%@%@",
            // street number
            selectedItem.subThoroughfare ?? "",
            firstSpace,
            // street name
            selectedItem.thoroughfare ?? "",
            comma,
            // city
            selectedItem.locality ?? "",
            secondSpace,
            // state
            selectedItem.administrativeArea ?? ""
        )
        return addressLine
    } //closes parseAddress


    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
        
   
       table.dataSource = self
        
        
        
    } //closes viewDidLoad
   
    //variables for map annotation
    
    var localSearchRequest:MKLocalSearchRequest!
    var localSearch:MKLocalSearch!
    var localSearchResponse:MKLocalSearchResponse!
    var error:NSError!
    var pointAnnotation:MKPointAnnotation!
    var pinAnnotationView:MKPinAnnotationView!
   


    let manager = CLLocationManager()
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        
        let location = locations.first
       
        
        let span = MKCoordinateSpanMake(0.01, 0.01)
        let region = MKCoordinateRegion(center: (location?.coordinate)!, span: span)
        map.setRegion(region, animated:false)
        
       
        
        // Get coffee places
        localSearchRequest = MKLocalSearchRequest()
        localSearchRequest.naturalLanguageQuery = "coffee"
        localSearchRequest.region = map.region
        let search = MKLocalSearch(request: localSearchRequest)
       
        
        
        search.start { response, _ in
            guard let response = response else {
                return
            }
          self.matchingItems = response.mapItems
          self.table.reloadData()
            
          //displays pins on map of each found location
            for item in response.mapItems {
      let annotation = MKPointAnnotation()
            annotation.coordinate = item.placemark.coordinate
            annotation.title = item.name
            annotation.subtitle = item.phoneNumber
                self.map.addAnnotation(annotation)
            }
        
    
        }}
  
            
            
            func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
                
                return self.matchingItems.count
            }
            
            
            func numberOfSections(in tableView: UITableView) -> Int {
                
                return 1
            }
    
    

        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
            let searchResult = self.matchingItems[indexPath.row]
            let cell = self.table.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            
           
           
            cell.textLabel?.text = searchResult.name
            cell.detailTextLabel?.text = self.parseAddress(selectedItem: searchResult.placemark)
            return cell
            
        }
    
    var nameofcafe: String!
    var adr:String!
    
    
    
    func tableView(_ tableView: UITableView!, didSelectRowAt indexPath: IndexPath!) {
      
        
        // Get Cell Label
        let indexPath = tableView.indexPathForSelectedRow;
        
     
        
        
        let selectedCell = tableView.cellForRow(at: indexPath!) as UITableViewCell!;
        
        nameofcafe = selectedCell?.textLabel?.text
        adr = selectedCell?.detailTextLabel?.text
        performSegue(withIdentifier: "detail", sender: self)
        
    }
            
        
         
            
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        
        if segue.identifier == "detail"{
            
            
            let dest =  segue.destination as! SelectedCafeViewController
            
              let indexPath = self.table.indexPathForSelectedRow!
            
           
            
           // let myIndexPath = self.tableView.indexPathForSelectedRow!
            
            let row = indexPath.row
            
            dest.name = matchingItems[row].name
            
            dest.address = matchingItems[row].phoneNumber
            
            dest.urlAddress = matchingItems[row].url
            
        
    
        }}}

