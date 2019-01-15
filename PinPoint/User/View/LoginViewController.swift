//
//  LoginViewController.swift
//  PinPoint
//
//  Created by Ibbi Khan on 14/01/2019.
//  Copyright © 2019 Ibbi Khan. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate, LoginProtocol {
    

    
    @IBOutlet weak var msgLabel: UILabel!
    @IBOutlet var fields: [UITextField]!
    @IBOutlet weak var loginBtn: UIButton!
    var presenter: LoginPresenter!
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter = LoginPresenter()
        presenter.delegate = self
        
        loginBtn.layer.cornerRadius = 4
        
        for i in fields {
            i.delegate = self
        }
    }
    
    
    @IBAction func loginBtnPressed(_ sender: Any) {
        presenter.validateData(user: UserCredentials(email: emailField.text!, password: passwordField.text!))
    }
    
    // extensions
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case emailField:
            passwordField.becomeFirstResponder()
        default:
            textField.resignFirstResponder()
        }
        return false
    }
    
    // protocols
    func displayMsg(msg: String) {
        msgLabel.text = msg
    }
    
    func loginSuccess() {
        performSegue(withIdentifier: "fromLoginToUser", sender: nil)
    }
}
