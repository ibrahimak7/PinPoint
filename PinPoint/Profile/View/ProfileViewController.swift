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
    @IBOutlet weak var nameLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = ProfilePresenter()
        presenter.delegate = self
        presenter.fetchProfile()
        // Do any additional setup after loading the view.
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
    func profileFetched(user: ProfileModel) {
        nameLabel.text = user.name
    }
    
}
