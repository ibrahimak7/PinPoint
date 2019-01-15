//
//  UserHomeViewController.swift
//  PinPoint
//
//  Created by Ibbi Khan on 14/01/2019.
//  Copyright © 2019 Ibbi Khan. All rights reserved.
//

import UIKit

class UserHomeViewController: UIViewController {
    
    @IBOutlet weak var login: UIButton!
    @IBOutlet weak var register: UIButton!
    override func viewDidLoad() {
        login.layer.cornerRadius = 4
        register.layer.cornerRadius = 4
        
        // setting up navigationcolor
        self.navigationController?.navigationBar.barTintColor = UIColor.white
    }
    
}
