//
//  ProfilePresenter.swift
//  PinPoint
//
//  Created by Ibbi Khan on 23/01/2019.
//  Copyright © 2019 Ibbi Khan. All rights reserved.
//

import Foundation
import Firebase
import FirebaseStorage
import SDWebImage
class ProfilePresenter: NSObject {
    var delegate: ProfileProtocol!
    var ref: DatabaseReference!
    let uid = Auth.auth().currentUser?.uid
    var uploadTask: StorageUploadTask!
    func saveUserName(name: String) {
        configDB()
        ref.child("Profile/\(uid!)/name").setValue(name)
        fetchProfile()
    }
    func saveWithImage(name: String, imageURL: String){
        configDB()
        let storageRef = Storage.storage().reference()
        let lastText = String((imageURL.suffix(4)))
        let imageRef = storageRef.child("Images/\(uid!+lastText)")
       uploadTask = imageRef.putFile(from: URL(string: imageURL)!, metadata: nil) { (storageRef, error) in
            guard storageRef != nil else {
                self.delegate.showMsg(msg: (error?.localizedDescription)!)
                return
            }
            imageRef.downloadURL(completion: { (dURL, error) in
               guard let url = dURL else {
                    self.delegate.showMsg(msg: (error?.localizedDescription)!)
                    return
            }
                self.ref.child("Profile/\(self.uid!)").setValue(["name":name,"image": url.absoluteString])
                self.fetchProfile()
                
            })
        }
        uploadTask.observe(StorageTaskStatus.progress) { (snapShot) in
            if snapShot.progress?.completedUnitCount != 0 {
                let percentage = ((snapShot.progress?.completedUnitCount)! * 100)/(snapShot.progress?.totalUnitCount)!
                let p = CGFloat(Int64(percentage))
                self.delegate.dpUploading(progress: p/100.0)
            }
        }
        
    }
    func fetchProfile() {
        configDB()
        ref.child("Profile/\(uid!)").observeSingleEvent(of: .value) { (snapShot) in
            if snapShot.exists() {
                let data = snapShot.value as? NSDictionary
                let name = data!["name"] as? String
                let url =  data!["image"] as? String
                let user = ProfileModel(name: name!, url: url!, uid: self.uid!)
                self.delegate.profileFetched(user: user)
            }
        }
    }
    func configDB(){
        ref = Database.database().reference()
    }
}
