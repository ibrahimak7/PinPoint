//
//  ChatController.swift
//  PinPoint
//
//  Created by Ibbi Khan on 30/01/2019.
//  Copyright © 2019 Ibbi Khan. All rights reserved.
//

import UIKit

class ChatController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextViewDelegate {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var textView: UITextView!
    let data = ["one","two","three"]
    var recieverID: String!
    override func viewDidLoad() {
        super.viewDidLoad()        
        tableView.delegate = self
        textView.delegate = self
        tableView.tableFooterView = UIView(frame: .zero)
        textView.layer.cornerRadius = 12
        print(recieverID)
    }
    @IBAction func sendButtonClicked(_ sender: Any) {
        textView.resignFirstResponder()
    }
    @IBAction func imageButtonClicked(_ sender: Any) {
    }

}
extension ChatController {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = data[indexPath.row]
        return cell
    }
}
