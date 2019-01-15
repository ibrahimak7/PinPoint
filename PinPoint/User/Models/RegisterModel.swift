//
//  RegisterModel.swift
//  PinPoint
//
//  Created by Ibbi Khan on 15/01/2019.
//  Copyright © 2019 Ibbi Khan. All rights reserved.
//

import Foundation
struct UserData {
    let name: String
    let email: String
    let password: String
    init(name: String, email: String, password: String) {
        self.name = name
        self.email = email
        self.password = password
    }
}
