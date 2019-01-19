//
//  PinsPresenter.swift
//  PinPoint
//
//  Created by Ibbi Khan on 19/01/2019.
//  Copyright © 2019 Ibbi Khan. All rights reserved.
//

import Foundation
import Firebase
import CoreLocation
class PinsPresenter: NSObject {
    var ref: DatabaseReference!
    
    func saveUserLocation(location: CLLocationCoordinate2D) {
        
        let uid = Auth.auth().currentUser?.uid
        ref = Database.database().reference()
        
        ref.child("UsersCordinates/\(uid!)").setValue(["latitude": location.latitude,"longitude": location.longitude])
        
    }
}
