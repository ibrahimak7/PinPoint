//
//  LoginViewController.swift
//  PinPoint
//
//  Created by Ibbi Khan on 14/01/2019.
//  Copyright © 2019 Ibbi Khan. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {

    
    @IBOutlet var fields: [UITextField]!
    @IBOutlet weak var emailField: UITextField! {
        didSet {
            emailField.tintColor = UIColor.lightGray
            emailField.setIcon(UIImage(named: "emailIcon")!)
            emailField.textAlignment = NSTextAlignment(CTTextAlignment.justified)
            emailField.borderStyle = .roundedRect
            
        }
    }
    
    @IBOutlet weak var passwordField: UITextField! {
        didSet {
            emailField.tintColor = UIColor.lightGray
            passwordField.setIcon(UIImage(named:"password")!)
            passwordField.textAlignment = NSTextAlignment(CTTextAlignment.justified)
            passwordField.borderStyle = .roundedRect
        }
    }
    
    @IBOutlet weak var loginBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        loginBtn.layer.cornerRadius = 4
        
        for i in fields {
            i.delegate = self
        }
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case emailField:
            passwordField.becomeFirstResponder()
        default:
            textField.resignFirstResponder()
        }
        return false
    }
}
