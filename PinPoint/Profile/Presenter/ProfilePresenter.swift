//
//  ProfilePresenter.swift
//  PinPoint
//
//  Created by Ibbi Khan on 23/01/2019.
//  Copyright © 2019 Ibbi Khan. All rights reserved.
//

import Foundation
import Firebase
class ProfilePresenter: NSObject {
    var delegate: ProfileProtocol!
    var ref: DatabaseReference!
    let uid = Auth.auth().currentUser?.uid
    func fetchProfile() {
        configDB()
        ref.child("Profile/\(uid!)").observeSingleEvent(of: .value) { (snapShot) in
            if snapShot.exists() {
                let data = snapShot.value as? NSDictionary
                let name = data!["name"] as? String
                let user = ProfileModel(name: name!)
                self.delegate.profileFetched(user: user)
            }
        }
    }
    func configDB(){
        ref = Database.database().reference()
    }
}
