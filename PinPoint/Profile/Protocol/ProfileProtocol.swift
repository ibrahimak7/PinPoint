//
//  ProfileProtocol.swift
//  PinPoint
//
//  Created by Ibbi Khan on 23/01/2019.
//  Copyright © 2019 Ibbi Khan. All rights reserved.
//

import Foundation
import UIKit
protocol ProfileProtocol {
    func profileFetched(user: ProfileModel)
    func showMsg(msg: String)
    func dpUploading(progress: CGFloat)
}
