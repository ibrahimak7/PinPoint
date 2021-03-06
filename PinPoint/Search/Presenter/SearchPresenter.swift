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
    let uid = Auth.auth().currentUser?.uid
    var familyMembers = [String]()
    func findUser(userName name: String) {
        usersList.removeAll()
        configDB()
        ref.child("Profile").observeSingleEvent(of: .value) { (snapShot) in
            if snapShot.exists() {
                let dataP = snapShot.value as? NSDictionary
                let keys = dataP?.allKeys
                self.ref.child("Family/\(self.uid!)").observeSingleEvent(of: .value, with: { (snapShot2) in
                    if snapShot2.exists() {
                        let data = snapShot2.value as? NSDictionary
                        self.familyMembers = data?.allKeys as! [String]
                    }
                    self.extractNewUsers(familyMembers: self.familyMembers, keys: (keys as? [String])!, data: dataP!, name: name)
                })
                
            }
        }
    }
    func extractNewUsers(familyMembers: [String], keys: [String], data: NSDictionary, name: String) {
        for key in keys {
            if !familyMembers.contains(key) {
                let user = data[key] as? NSDictionary
                if name == user!["name"]! as? String {
                    let name = user!["name"]! as? String
                    self.usersList.append(SearchModel(name: name!, id: key))
                }
            }
        }
        self.delegate.searchComplete(searchDataFetched: self.usersList)
    }
    func getAllRequests(){
        configDB()
        var userIDs = [String]()
        ref.child("Family/\(uid!)").observeSingleEvent(of: .value) { (snapShot) in
            if snapShot.exists() {
                let data = snapShot.value as? NSDictionary
                let keys = data?.allKeys
                for key in (keys as? [String])! {
                    let status = data![key] as? String
                    if status == "pending" {
                        userIDs.append(key)
                    }
                }
                self.pullProfiles(ids: userIDs)
            }
        }
    }
    func pullProfiles(ids: [String]){
        usersList.removeAll()
        for key in ids {
            print(key)
            ref.child("Profile/\(key)").observeSingleEvent(of: .value) { (snapShot) in
                let data = snapShot.value as? NSDictionary
                let name = data!["name"] as? String
                self.usersList.append(SearchModel(name: name!, id: key))
                self.delegate.fetchAllRequests(fetchedRequests: self.usersList)
            }
        }
    }
    func getSentRequests(){
        var userIDs = [String]()
        configDB()
        ref.child("Family/\(uid!)").observeSingleEvent(of: .value) { (snapShot) in
            if snapShot.exists() {
                let data = snapShot.value as? NSDictionary
                let keys = data?.allKeys
                for key in (keys as? [String])! {
                    let status = data![key] as? String
                    if status == "sent" {
                        userIDs.append(key)
                    }
                }
            }
            self.pullProfiles(ids: userIDs)
        }
    }
    func addUser(userID id: String, row: Int, sender: String, reciever: String){
        configDB()
        ref.child("Family/\(id)/\(uid!)").setValue(reciever)
        ref.child("Family/\(uid!)/\(id)").setValue(sender)
        self.delegate.userAdded(row: row)
    }
    func cancelUser(userID id: String, row: Int){
        configDB()
        ref.child("Family/\(id)/\(uid!)").setValue(nil)
        ref.child("Family/\(uid!)/\(id)").setValue(nil)
        self.delegate.userRemoved(row: row)
    }
    func configDB(){
        ref = Database.database().reference()
    }
}
