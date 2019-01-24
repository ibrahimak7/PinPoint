//
//  ProfileModel.swift
//  PinPoint
//
//  Created by Ibbi Khan on 23/01/2019.
//  Copyright © 2019 Ibbi Khan. All rights reserved.
//

import Foundation
struct ProfileModel {
    let name: String
    let imageURL: String
    init(name: String, url: String) {
        self.name = name
        self.imageURL = url
    }
}
