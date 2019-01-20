//
//  SearchViewController.swift
//  PinPoint
//
//  Created by Ibbi Khan on 19/01/2019.
//  Copyright © 2019 Ibbi Khan. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource, SearchProtocol {
    
    var data = [String]()
    let presenter = SearchPresenter()
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.delegate = self
        searchBar.delegate = self
        tableView.delegate = self
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Requests"
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
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
        cell?.nameLabel.text = data[indexPath.row]
//        cell?.textLabel?.text = data[indexPath.row]
        return cell!
    }
    func searchComplete(searchDataFetched users: [String], ids: [String]) {
        data = users
        tableView.reloadData()
    }
}
