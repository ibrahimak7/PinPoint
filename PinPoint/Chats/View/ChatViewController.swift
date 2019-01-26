//
//  ChatViewController.swift
//  PinPoint
//
//  Created by Ibbi Khan on 24/01/2019.
//  Copyright © 2019 Ibbi Khan. All rights reserved.
//

import UIKit

class ChatViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    

    
    @IBOutlet weak var topSegment: UISegmentedControl!
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        tableView.tableFooterView = UIView(frame: .zero)
        super.viewDidLoad()
        tableView.delegate = self
        let font = UIFont.systemFont(ofSize: 20)
        topSegment.setTitleTextAttributes([NSAttributedString.Key.font: font],
                                                for: .normal)
        topSegment.removeBorders()

        // Do any additional setup after loading the view.
        
    }
    
    @IBAction func segmentClicked(_ sender: UISegmentedControl) {
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "chatCell") as? ChatsCell
        cell?.userDp.image = UIImage(named: "userPro")
        cell?.userName.text = "Dummy"
        return cell!
    }
    
}
