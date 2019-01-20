//
//  SearchViewController.swift
//  PinPoint
//
//  Created by Ibbi Khan on 19/01/2019.
//  Copyright © 2019 Ibbi Khan. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource, SearchProtocol {

    var data = [SearchModel]()
    let presenter = SearchPresenter()
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    var headerTitle = "Users"
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView(frame: .zero)
        presenter.delegate = self
        searchBar.delegate = self
        tableView.delegate = self
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return headerTitle
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        data.removeAll()
        tableView.reloadData()
        self.presenter.findUser(userName: searchBar.text!)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "searchCell") as? SearchTableCell
        cell?.selectionStyle = .none
        cell?.nameLabel.text = data[indexPath.row].userName
        cell?.addUser.addTarget(self, action: #selector(addBtnTapped(_:)), for: .touchUpInside)
//        cell?.textLabel?.text = data[indexPath.row]
        return cell!
    }
    @objc func addBtnTapped(_ sender: UIButton){
//        let point = sender.convert(CGPoint.zero, to: tableView as UIView)
//        let indexPath: IndexPath! = tableView.indexPathForRow(at: point)
        
    }
    
    @IBAction func segmentForTableView(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            print("searches clicked")
        case 1:
            print("Requests clicked")
        default:
            print("Send clicked")
        }
    }
    // presenter delegates
    func searchComplete(searchDataFetched users: [SearchModel]) {
        data = users
        tableView.reloadData()
    }
}
