//
//  PinsViewController.swift
//  PinPoint
//
//  Created by Ibbi Khan on 15/01/2019.
//  Copyright © 2019 Ibbi Khan. All rights reserved.
//

import UIKit
import Firebase
import GoogleMaps
import GooglePlaces
class PinsViewController: UIViewController, CLLocationManagerDelegate {
    var presenter: PinsPresenter!
    var ref: DatabaseReference!
    var locationManager = CLLocationManager()
    var defaultLocation = CLLocation(latitude: 33.5889, longitude: 71.4429)
    var mapView: GMSMapView!
    let zoomLevel: Float = 15.0
    override func viewDidLoad() {
        presenter = PinsPresenter()
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        
        // givig defualt map setup
        setupMap()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        // enable or disable feature of app
        self.checkPermission()
        
    }
    func checkPermission(){
        if CLLocationManager.locationServicesEnabled() {
            switch CLLocationManager.authorizationStatus() {
            case .notDetermined, .restricted, .denied:
                self.givePopUp(msg: "Location Services is not working. You won't be able use location features in the app")
            case .authorizedAlways, .authorizedWhenInUse:
                // if we have permission we will update location and use locationManager.
                locationManager.distanceFilter = 50
                locationManager.startUpdatingLocation()
                locationManager.allowDeferredLocationUpdates(untilTraveled: 2, timeout: 120)
                locationManager.delegate = self
            }
        }else{
            print("location is disable")
        }
        
    }
    func setupMap() {
        let camera = GMSCameraPosition.camera(withLatitude: defaultLocation.coordinate.latitude, longitude: defaultLocation.coordinate.longitude, zoom: zoomLevel)
        mapView = GMSMapView.map(withFrame: CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height), camera: camera)
        mapView.isMyLocationEnabled = true
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(mapView)
    }
    
    // delegates properties
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.last?.coordinate
        // saving user location
        self.presenter.saveUserLocation(location: location!)
    }
    // Handle location manager errors.
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        locationManager.stopUpdatingLocation()
        print("Error: \(error)")
    }
    func givePopUp(msg: String){
        let alert = UIAlertController(title: "Error", message: msg, preferredStyle: .alert)
        let ok = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(ok)
        self.present(alert, animated: true)
    }
}
