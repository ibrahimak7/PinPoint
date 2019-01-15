//
//  LoginModel.swift
//  PinPoint
//
//  Created by Ibbi Khan on 15/01/2019.
//  Copyright © 2019 Ibbi Khan. All rights reserved.
//

import Foundation
struct UserCredentials {
    let email: String
    let password: String
    init(email: String, password: String) {
        self.email = email
        self.password = password
    }
}
