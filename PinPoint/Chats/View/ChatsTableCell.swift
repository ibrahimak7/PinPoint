//
//  ChatsTableCell.swift
//  PinPoint
//
//  Created by Ibbi Khan on 30/01/2019.
//  Copyright © 2019 Ibbi Khan. All rights reserved.
//

import UIKit

class ChatsTableCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var lastMsg: UILabel!
    @IBOutlet weak var dpView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
