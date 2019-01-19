//
//  SearchViewController.swift
//  PinPoint
//
//  Created by Ibbi Khan on 19/01/2019.
//  Copyright © 2019 Ibbi Khan. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource {
    var data = [String]()
    let presenter = SearchPresenter()
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        tableView.delegate = self
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.presenter.findUser(userName: searchBar.text!)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "searchCell")
        cell?.textLabel?.text = data[indexPath.row]
        return cell!
    }
}
