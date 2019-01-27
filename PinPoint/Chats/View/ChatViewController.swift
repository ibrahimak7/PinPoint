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
        
    }
    
    @IBAction func segmentClicked(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            
        }else{
            removeAndReload()
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "chatCell") as? ChatsCell
        cell?.userDp.sd_setImage(with: URL(string: data[indexPath.row].imageURL), completed: nil)
        cell?.userName.text = data[indexPath.row].name
        return cell!
    }
    func removeAndReload(){
        data.removeAll()
        tableView.reloadData()
    }
    func fetchFamily(users: [ProfileModel]) {
        data = users
        tableView.reloadData()
    }
}
