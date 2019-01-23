//
//  SearchProtocol.swift
//  PinPoint
//
//  Created by Ibbi Khan on 19/01/2019.
//  Copyright © 2019 Ibbi Khan. All rights reserved.
//

import Foundation
protocol SearchProtocol {
    func searchComplete(searchDataFetched users: [SearchModel])
    func userAdded(row: Int)
    func fetchAllRequests(fetchedRequests users: [SearchModel])
    func userRemoved(row: Int)
}
