//
//  ChatPresenter.swift
//  PinPoint
//
//  Created by Ibbi Khan on 26/01/2019.
//  Copyright © 2019 Ibbi Khan. All rights reserved.
//

import Foundation
import Firebase
class ChatPresenter: NSObject {
    var ref: DatabaseReference!
    var delegate: ChatProtocol!
    var usersList = [ProfileModel]()
    var uid = Auth.auth().currentUser?.uid
    func fetchFamily(){
        configDB()
        var users = [String]()
        ref.child("Family/\(uid!)").observeSingleEvent(of: .value) { (snapShot) in
            if snapShot.exists() {
                let data = snapShot.value as? NSDictionary
                let keys = data?.allKeys as? [String]
                for key in keys! {
                    if data![key] as? String == "added" {
                        users.append(key)
                    }
                }
                self.fetchProfile(ids: users)
            }
        }
    }
    func fetchProfile(ids: [String]) {
        usersList.removeAll()
        for key in ids {
            ref.child("Profile/\(key)").observeSingleEvent(of: .value) { (snapShot) in
                if snapShot.exists() {
                    let data = snapShot.value as? NSDictionary
                    let name = data!["name"] as? String
                    let url =  data!["image"] as? String
                    self.usersList.append(ProfileModel(name: name!, url: url!, uid: key))
                    self.delegate.fetchFamily(users: self.usersList)
                }
            }
        }
    }
    func configDB(){
        ref = Database.database().reference()
    }
}
