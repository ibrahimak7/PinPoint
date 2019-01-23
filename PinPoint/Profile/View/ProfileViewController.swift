//
//  ProfileViewController.swift
//  PinPoint
//
//  Created by Ibbi Khan on 16/01/2019.
//  Copyright © 2019 Ibbi Khan. All rights reserved.
//

import UIKit
import Firebase
class ProfileViewController: UIViewController, ProfileProtocol {
    var presenter: ProfilePresenter!
    @IBOutlet weak var dpImageView: UIImageView!
    @IBOutlet weak var userName: UITextField!
    
    @IBOutlet weak var changeBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = ProfilePresenter()
        presenter.delegate = self
        presenter.fetchProfile()
        // Do any additional setup after loading the view.
        userName.borderStyle = .none
        dpImageView.layer.cornerRadius = dpImageView.bounds.height/2
        changeBtn.isHidden = true
        forCancelButton()
    }
    
    @IBAction func logoutClicked(_ sender: Any) {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            UserDefaults.standard.removeObject(forKey: "user")
            let userHome = self.storyboard?.instantiateViewController(withIdentifier: "userHomeVC") as! UserHomeViewController
            
            let delegate = UIApplication.shared.delegate as! AppDelegate
            delegate.window?.rootViewController = userHome
            
            delegate.rememberLogin()
        } catch let signOutError as NSError {
            let alert = UIAlertController(title: "Error", message: "\(signOutError)", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(action)
            self.present(alert, animated: true)
        }
        
    }
    
    @IBAction func cancelBtn(_ sender: Any) {
    }
    
    @IBAction func editSave(_ sender: UIBarButtonItem) {
        setUiWhenHitEdit()
    }
    @objc func saveProileEdit(){
        setUiWhenSaveHit()
    }
    func profileFetched(user: ProfileModel) {
        userName.text = user.name
    }
    func setUiWhenHitEdit(){
        UIView.animate(withDuration: 0.7) {
            self.changeBtn.isHidden = false
            self.userName.isEnabled = true
            self.userName.setBottomBorder(color: "000000")
            self.navigationItem.leftBarButtonItem?.isEnabled = true
            self.navigationItem.leftBarButtonItem?.tintColor = UIColor(hexString: "1560D2")
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(self.saveProileEdit))
        }
    }
    func setUiWhenSaveHit() {
        UIView.animate(withDuration: 0.7) {
            self.forCancelButton()
            self.changeBtn.isHidden = true
            self.userName.setBottomBorder(color: "ffffff")
            self.userName.isEnabled = false
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Edit", style: .done, target: self, action: #selector(self.editSave(_:)))
        }
    }
    func forCancelButton(){
        self.navigationItem.leftBarButtonItem?.isEnabled = false
        self.navigationItem.leftBarButtonItem?.tintColor = UIColor.clear
    }
    
    @IBAction func changeImage(_ sender: Any) {
    }
}
