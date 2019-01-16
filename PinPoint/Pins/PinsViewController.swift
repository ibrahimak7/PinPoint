//
//  PinsViewController.swift
//  PinPoint
//
//  Created by Ibbi Khan on 15/01/2019.
//  Copyright © 2019 Ibbi Khan. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces
class PinsViewController: UIViewController {
    
    var defaultLocation = CLLocation(latitude: 33.5889, longitude: 71.4429)
    var mapView: GMSMapView!
    let zoomLevel: Float = 15.0
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        
        let camera = GMSCameraPosition.camera(withLatitude: defaultLocation.coordinate.latitude, longitude: defaultLocation.coordinate.longitude, zoom: zoomLevel)
        let mapView = GMSMapView.map(withFrame: CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height), camera: camera)
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(mapView)
    }

}
