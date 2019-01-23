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
    var selectedTab = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView(frame: .zero)
        presenter.delegate = self
        searchBar.delegate = self
        tableView.delegate = self
    }
    func removeAndReload(){
        data.removeAll()
        tableView.reloadData()
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return headerTitle
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        removeAndReload()
        switch selectedTab {
        case 0:
            self.presenter.findUser(userName: searchBar.text!)
        case 1:
            print("Request are here")
        default:
            print("You are looking sent requests")
        }
        
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
        configureCellBtn(cell: cell!)
//        cell?.textLabel?.text = data[indexPath.row]
        return cell!
    }
    @objc func addBtnTapped(_ sender: UIButton){
        let point = sender.convert(CGPoint.zero, to: tableView as UIView)
        let indexPath: IndexPath! = tableView.indexPathForRow(at: point)
        if sender.titleLabel?.text == "Add" {
            self.presenter.addUser(userID: data[indexPath.row].userID, row: indexPath.row, sender: "sent", reciever: "pending")
        }else if sender.titleLabel?.text == "Accept" {
            self.presenter.addUser(userID: data[indexPath.row].userID, row: indexPath.row, sender: "added", reciever: "added")
        }
        
    }
    func configureCellBtn(cell: SearchTableCell) {
        switch selectedTab {
        case 0:
            cell.addUser.setTitle("Add", for: .normal)
        case 1:
            cell.addUser.setTitle("Accept", for: .normal)
        default:
            cell.addUser.setTitle("Cancel", for: .normal)
        }
        cell.addUser.addTarget(self, action: #selector(addBtnTapped(_:)), for: .touchUpInside)
    }
    @IBAction func segmentForTableView(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            headerTitle = "Search"
            removeAndReload()
            searchBar.text = ""
            selectedTab = 0
            print("searches clicked")
        case 1:
            headerTitle = "Requests"
            removeAndReload()
            searchBar.text = ""
            selectedTab = 1
            self.presenter.getAllRequests()
        default:
            headerTitle = "Sent Requests"
            removeAndReload()
            searchBar.text = ""
            selectedTab = 2
            self.presenter.getSentRequests()
        }
    }
    // presenter delegates
    func searchComplete(searchDataFetched users: [SearchModel]) {
        data = users
        tableView.reloadData()
    }
    func userAdded(row: Int) {
        data.remove(at: row)
        tableView.deleteRows(at: [IndexPath(row: row, section: 0)], with: .automatic)
        
    }
    func fetchAllRequests(fetchedRequests users: [SearchModel]) {
        data = users
        tableView.reloadData()
    }
}
