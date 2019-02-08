//
//  ChatViewController.swift
//  PinPoint
//
//  Created by Ibbi Khan on 24/01/2019.
//  Copyright © 2019 Ibbi Khan. All rights reserved.
//

import UIKit
import SDWebImage
class ChatViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, ChatProtocol {
    var presenter: ChatPresenter!
    @IBOutlet weak var topSegment: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    var data = [ProfileModel]()
    var selectedTab = 0
    var reciverID: String!
    override func viewDidLoad() {
        tableView.tableFooterView = UIView(frame: .zero)
        super.viewDidLoad()
        presenter = ChatPresenter()
        presenter.delegate = self
        tableView.delegate = self
        let font = UIFont.systemFont(ofSize: 20)
        topSegment.setTitleTextAttributes([NSAttributedString.Key.font: font],
                                                for: .normal)
        topSegment.removeBorders()

        // Do any additional setup after loading the view.
        self.hidesBottomBarWhenPushed = false
    }
    
    @IBAction func segmentClicked(_ sender: UISegmentedControl) {
        removeAndReload()
        if sender.selectedSegmentIndex == 0 {
            selectedTab = 0
        }else{
            selectedTab = 1
            self.presenter.fetchFamily()
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if selectedTab == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "familyCell") as? ChatsCell
            cell?.userDp.sd_setImage(with: URL(string: data[indexPath.row].imageURL), completed: nil)
            cell?.userName.text = data[indexPath.row].name
            return cell!
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChatsTableCell") as? ChatsTableCell
        cell?.textLabel?.text = "data"
        return cell!
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        reciverID = data[indexPath.row].uid
        self.performSegue(withIdentifier: "toMsgView", sender: nil)
    }
    func removeAndReload(){
        data.removeAll()
        tableView.reloadData()
    }
    func fetchFamily(users: [ProfileModel]) {
        data = users
        tableView.reloadData()
    }
    @IBAction func itemClicked(_ sender: Any) {
        performSegue(withIdentifier: "toMsgView", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toMsgView" {
            let destination = segue.destination as? ChatController
            destination?.recieverID = reciverID
        }
    }
}
