//
//  RegisterPresenter.swift
//  PinPoint
//
//  Created by Ibbi Khan on 15/01/2019.
//  Copyright © 2019 Ibbi Khan. All rights reserved.
//

import Foundation
import Firebase
class RegisterPresenter: NSObject {
    var ref: DatabaseReference!
    var delegate: RegisterProtocol!
    
    func checkData(userData: UserData){
        if userData.name.count != 0 {
            if userData.email.count != 0 {
                if userData.password.count != 0 {
                    self.registerUser(name: userData.name, email: userData.email, password: userData.password)
                }else{
                    self.delegate.displayMessage(msg: "Password cannot be empty")
                }
            }else{
                self.delegate.displayMessage(msg: "Email cannot be empty")
            }
        }else{
            self.delegate.displayMessage(msg: "Name cannot be empty")
        }
    }
    fileprivate func registerUser(name: String,email: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            guard let user = result?.user else {
                self.delegate.displayMessage(msg: (error?.localizedDescription)!)
                return
            }
            self.createProfile(name: name, uuid: user.uid)
        }
    }
    fileprivate func createProfile(name: String, uuid: String) {
        ref = Database.database().reference()
        ref.child("Profile/\(uuid)").setValue(["name":name]) { (err, response) in
            guard err == nil else { return }
            self.delegate.success()
        }
    }
    
}
