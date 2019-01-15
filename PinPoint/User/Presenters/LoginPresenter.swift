//
//  LoginPresenter.swift
//  PinPoint
//
//  Created by Ibbi Khan on 15/01/2019.
//  Copyright © 2019 Ibbi Khan. All rights reserved.
//

import Foundation
import Firebase
class LoginPresenter: NSObject {
    var delegate: LoginProtocol!
    
    func validateData(user: UserCredentials) {
        if user.email.count != 0 {
            if user.password.count != 0 {
                verifyCredentials(email: user.email, password: user.password)
            }else{
                delegate.displayMsg(msg: "Password is required")
            }
        }else{
            delegate.displayMsg(msg: "Email is required")
        }
    }
    fileprivate func verifyCredentials(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { (response, err) in
            guard (response?.user) != nil else {
                self.delegate.displayMsg(msg: (err?.localizedDescription)!)
                return
            }
            self.delegate.loginSuccess()
        }
    }
}
