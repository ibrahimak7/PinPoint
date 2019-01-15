//
//  RegisterViewController.swift
//  PinPoint
//
//  Created by Ibbi Khan on 15/01/2019.
//  Copyright © 2019 Ibbi Khan. All rights reserved.
//

import UIKit
class RegisterViewController: UIViewController, UITextFieldDelegate, RegisterProtocol {
    
    var presenter: RegisterPresenter!
    @IBOutlet var fields: [UITextField]!
    @IBOutlet weak var registerBtn: UIButton!
    
    @IBOutlet weak var msgLabel: UILabel!
    @IBOutlet weak var nameField: UITextField! {
        didSet {
            nameField.tag = 0
            nameField.tintColor = UIColor.lightGray
            nameField.setIcon(UIImage(named:"profile")!)
            nameField.textAlignment = NSTextAlignment(CTTextAlignment.justified)
            nameField.borderStyle = .roundedRect
        }
    }
    
    @IBOutlet weak var emailField: UITextField! {
        didSet {
            emailField.tag = 1
            emailField.tintColor = UIColor.lightGray
            emailField.setIcon(UIImage(named: "emailIcon")!)
            emailField.textAlignment = NSTextAlignment(CTTextAlignment.justified)
            emailField.borderStyle = .roundedRect
            
        }
    }
    @IBOutlet weak var passwordField: UITextField! {
        didSet {
            passwordField.tag = 2
            passwordField.tintColor = UIColor.lightGray
            passwordField.setIcon(UIImage(named:"password")!)
            passwordField.textAlignment = NSTextAlignment(CTTextAlignment.justified)
            passwordField.borderStyle = .roundedRect
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = RegisterPresenter()
        presenter.delegate = self
        registerBtn.layer.cornerRadius = 4
        // assaigning delegates to fields
        for i in fields {
            i.delegate = self
        }
        // Do any additional setup after loading the view.
        
    }
    @IBAction func RegisterBtnPressed(_ sender: Any) {
        self.presenter.checkData(userData: UserData(name: nameField.text!, email: emailField.text!, password: passwordField.text!))
    }
    
    // Extension of TextField
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case nameField:
            emailField.becomeFirstResponder()
        case emailField:
            passwordField.becomeFirstResponder()
        default:
            textField.resignFirstResponder()
        }
        return false
    }
    // Protocols
    
    func displayMessage(msg: String) {
        msgLabel.text = msg
    }
    
    func success() {
        self.performSegue(withIdentifier: "fromRegisterToUser", sender: nil)
    }
}
