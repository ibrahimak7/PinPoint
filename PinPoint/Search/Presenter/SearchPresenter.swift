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
    var delegate: SearchProtocol!
    var ref: DatabaseReference!
    var foundUsers = [String]()
    var foundUsersIds = [String]()
    func findUser(userName name: String) {
        ref = Database.database().reference()
        ref.child("Profile").observeSingleEvent(of: .value) { (snapShot) in
            if snapShot.exists() {
                let data = snapShot.value as? NSDictionary
                let keys = data?.allKeys
                for key in keys! {
                    let user = data![key] as? NSDictionary
                    if name == user!["name"]! as? String {
                        let name = user!["name"]!
                        self.foundUsers.append(name as! String)
                        self.foundUsersIds.append(key as! String)
                        self.delegate.searchComplete(searchDataFetched: self.foundUsers, ids: self.foundUsersIds)
                    }
                }
            }
        }
    }
}
