//
//  SearchPresenter.swift
//  PinPoint
//
//  Created by Ibbi Khan on 19/01/2019.
//  Copyright © 2019 Ibbi Khan. All rights reserved.
//

import Foundation
import Firebase
class SearchPresenter: NSObject {
    var ref: DatabaseReference!
    
    func findUser(userName name: String) {
        ref = Database.database().reference()
        ref.child("Profile").observeSingleEvent(of: .value) { (snapShot) in
            if snapShot.exists() {
                let data = snapShot.value as? NSDictionary
                let keys = data?.allKeys
                for key in keys! {
                    let user = data![key] as? [String:String]
                    if name == user!["name"] {
                        print("Value matched")
                    }
                }
            }
        }
    }
}
