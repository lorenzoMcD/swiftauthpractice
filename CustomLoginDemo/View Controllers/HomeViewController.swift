//
//  HomeViewController.swift
//  CustomLoginDemo
//
//  Created by Lorenzo McDaniel on 12/14/19.
//  Copyright © 2019 Lorenzo McDaniel. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation


class HomeViewController: UIViewController , CLLocationManagerDelegate {

    
    
    @IBOutlet weak var mapView: MKMapView!
    
    
    @IBOutlet weak var requestRide: UIButton!
    
    
    @IBOutlet weak var recenterLocation: UIButton!
    
    
    // how much want to zoom in
    let regionInMeters: Double = 10000
    
    let locationManager = CLLocationManager()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkLocationServices()
  
    }
    

    
    
    
    func setupLocationManager() {
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    
    
    func centerViewOnUserLocation() {
        
        if let location = locationManager.location?.coordinate {
            
            let region = MKCoordinateRegion.init(center: location, latitudinalMeters: regionInMeters, longitudinalMeters: regionInMeters)
            mapView.setRegion(region, animated: true)
            
            
            
        }
        
    }
    
    
    
    
    
    func checkLocationServices() {
        
        if CLLocationManager.locationServicesEnabled() {
            // setup location manager
            setupLocationManager()
            checkLocationAuthorization()
     
        }
        else {
            // show alert letting user know they have to turn this on
            
            
            
        }
    }
        
    var currentLocation: CLLocation!
    
        func checkLocationAuthorization() {
            
            switch CLLocationManager.authorizationStatus() {
                
            case .authorizedWhenInUse:
                // do map stuff
                mapView.showsUserLocation = true
                centerViewOnUserLocation()
                locationManager.startUpdatingLocation()
                
                currentLocation = locationManager.location
                
                
                
                // these are coordinates of the user when they open app need to figure out way to send this info to data base under this users name
                print("this is my current log:" ,"\(currentLocation.coordinate.longitude)")
                print("this is my current lat:" ,"\(currentLocation.coordinate.latitude)")
                
                
                break
       
            case .denied:
                // show alert instruct how to turn on permmissions
                break
            
            case .notDetermined:
                locationManager.requestWhenInUseAuthorization()

            case .restricted:
                
                // show alert knowing whats up
                
                break
                
            case .authorizedAlways:
                break
            
                
            @unknown default:
                fatalError("Error has occured!")
            }
        }
            
            
        
  
    
        func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
                    
            guard let location = locations.last else {return}
            let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude , longitude: location.coordinate.longitude)
            let region = MKCoordinateRegion.init(center: location.coordinate, latitudinalMeters: regionInMeters, longitudinalMeters: regionInMeters)
            mapView.setRegion(region,animated:true)
        }
    
        func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
            
            // well be back
        }
        
        
        

    
    @IBAction func recenterLocationTapped(_ sender: Any) {
    
    
        centerViewOnUserLocation()
    
    
    
    }
    
    
    
    
    
    
    
    
        
        
    
    
    
}
    
    
    
    
    
    

        
    
 
    
    
    
    

