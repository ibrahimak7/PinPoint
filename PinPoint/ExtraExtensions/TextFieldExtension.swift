//
//  TextFieldExtension.swift
//  PinPoint
//
//  Created by Ibbi Khan on 14/01/2019.
//  Copyright © 2019 Ibbi Khan. All rights reserved.
//

import UIKit
import Foundation
extension UITextField {
    func setIcon(_ image: UIImage) {
        let iconView = UIImageView(frame:
            CGRect(x: 10, y: 5, width: 20, height: 20))
        iconView.image = image
        let iconContainerView: UIView = UIView(frame:
            CGRect(x: 25, y: 0, width: 35, height: 30))
        iconContainerView.addSubview(iconView)
        leftView = iconContainerView
        leftViewMode = .always
    }
}
