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
    var usersList = [SearchModel]()
    
    func findUser(userName name: String) {
        usersList.removeAll()
        configDB()
        ref.child("Profile").observeSingleEvent(of: .value) { (snapShot) in
            if snapShot.exists() {
                let data = snapShot.value as? NSDictionary
                let keys = data?.allKeys
                for key in keys! {
                    let user = data![key] as? NSDictionary
                    if name == user!["name"]! as? String {
                        let name = user!["name"]! as? String
                        self.usersList.append(SearchModel(name: name!, id: key as! String))
                    }
                }
                self.delegate.searchComplete(searchDataFetched: self.usersList)
            }
        }
    }
    func getAllRequests(){
        let uid = Auth.auth().currentUser?.uid
        configDB()
        ref.child("Requests/\(uid!)").observeSingleEvent(of: .value) { (snapShot) in
            if snapShot.exists() {
                
            }
        }
    }
    func addUser(userID id: String, row: Int){
        configDB()
        ref.child("Requests/\(id)").setValue([Auth.auth().currentUser?.uid: "added"])
        self.delegate.userAdded(row: row)
    }
    func configDB(){
        ref = Database.database().reference()
    }
}
