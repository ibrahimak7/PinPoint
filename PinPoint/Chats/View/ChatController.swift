//
//  ChatController.swift
//  PinPoint
//
//  Created by Ibbi Khan on 30/01/2019.
//  Copyright © 2019 Ibbi Khan. All rights reserved.
//

import UIKit

class ChatController: UIViewController {

    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var textView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView(frame: .zero)
        textView.layer.cornerRadius = 12
        // Do any additional setup after loading the view.
    }
    @IBAction func sendButtonClicked(_ sender: Any) {
    }
    @IBAction func imageButtonClicked(_ sender: Any) {
    }
    

}
