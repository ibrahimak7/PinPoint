//
//  SearchModel.swift
//  PinPoint
//
//  Created by Ibbi Khan on 20/01/2019.
//  Copyright © 2019 Ibbi Khan. All rights reserved.
//

import Foundation
struct SearchModel {
    let userName: String
    let userID: String
//    let inFamilyList: Bool
    init(name: String, id: String) {
        self.userID = id
        self.userName = name
//        self.inFamilyList = inFamily
    }
}
