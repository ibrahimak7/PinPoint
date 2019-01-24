//
//  ProfileViewController.swift
//  PinPoint
//
//  Created by Ibbi Khan on 16/01/2019.
//  Copyright © 2019 Ibbi Khan. All rights reserved.
//

import UIKit
import Firebase
import SDWebImage
import GTProgressBar
class ProfileViewController: UIViewController, ProfileProtocol, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    var presenter: ProfilePresenter!
    @IBOutlet weak var dpImageView: UIImageView!
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var changeBtn: UIButton!
    var isImageChanged = false
    var imageUrl: String!
    var progressBar: GTProgressBar!
    @IBOutlet weak var progressView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = ProfilePresenter()
        presenter.delegate = self
        presenter.fetchProfile()
        setupProgressBar()
        // Do any additional setup after loading the view.
        userName.borderStyle = .none
        dpImageView.layer.cornerRadius = dpImageView.bounds.height/2
        dpImageView.clipsToBounds = true
        changeBtn.isHidden = true
        forCancelButton()
    }
    func setupProgressBar(){
        progressBar = GTProgressBar(frame: CGRect(x: 0, y: 0, width: progressView.bounds.width, height: 15))
        progressBar.progress = 1
        progressBar.barBorderColor = UIColor(red:0.35, green:0.80, blue:0.36, alpha:1.0)
        progressBar.barFillColor = UIColor(red:0.35, green:0.80, blue:0.36, alpha:1.0)
        progressBar.barBackgroundColor = UIColor(red:0.77, green:0.93, blue:0.78, alpha:1.0)
        progressBar.barBorderWidth = 1
        progressBar.barFillInset = 2
        progressBar.labelTextColor = UIColor(red:0.35, green:0.80, blue:0.36, alpha:1.0)
        progressBar.progressLabelInsets = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
        progressBar.font = UIFont.boldSystemFont(ofSize: 18)
        progressBar.labelPosition = GTProgressBarLabelPosition.right
        progressBar.barMaxHeight = 12
        progressBar.direction = GTProgressBarDirection.anticlockwise
        
        progressView.addSubview(progressBar)
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
        setUiWhenSaveHit()
    }
    
    @IBAction func editSave(_ sender: UIBarButtonItem) {
        setUiWhenHitEdit()
    }
    @objc func saveProileEdit(){
        if isImageChanged {
            self.presenter.saveWithImage(name: userName.text!, imageURL: imageUrl)
        }else{
            self.presenter.saveUserName(name: userName.text!)
        }
    }
    func profileFetched(user: ProfileModel) {
        userName.text = user.name
        dpImageView.sd_setImage(with: URL(string: user.imageURL), completed: nil)
        setUiWhenSaveHit()
    }
    func setUiWhenHitEdit(){
        UIView.animate(withDuration: 0.8) {
            self.changeBtn.isHidden = false
            self.userName.isEnabled = true
            self.userName.setBottomBorder(color: "D3D3D3")
            self.navigationItem.leftBarButtonItem?.isEnabled = true
            self.navigationItem.leftBarButtonItem?.tintColor = UIColor(hexString: "1560D2")
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(self.saveProileEdit))
        }
    }
    func setUiWhenSaveHit() {
        self.forCancelButton()
        self.changeBtn.isHidden = true
        self.userName.setBottomBorder(color: "ffffff")
        self.userName.isEnabled = false
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Edit", style: .done, target: self, action: #selector(self.editSave(_:)))
    }
    func forCancelButton(){
        self.navigationItem.leftBarButtonItem?.isEnabled = false
        self.navigationItem.leftBarButtonItem?.tintColor = UIColor.clear
    }
    
    @IBAction func changeImage(_ sender: Any) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = false
        picker.sourceType = .photoLibrary
        self.present(picker, animated: true)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        dpImageView.image = image
        let fileUrl = info[UIImagePickerController.InfoKey.imageURL] as? URL
        if fileUrl != nil {
            imageUrl = fileUrl?.absoluteString
        }
        isImageChanged = true
        self.dismiss(animated: true, completion: nil)
    }
    func showMsg(msg: String) {
        print(msg)
    }
    func dpUploading(progress: CGFloat) {
        print(progress)
        UIView.animate(withDuration: 0.3, animations: {
            self.progressView.alpha = 1
        })
        progressBar.animateTo(progress: progress)
        if progress == 1 {
            UIView.animate(withDuration: 0.3, animations: {
                self.progressView.alpha = 0
            })
        }
        
    }
}
