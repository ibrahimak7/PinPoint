//
//  ChatsCell.swift
//  PinPoint
//
//  Created by Ibbi Khan on 26/01/2019.
//  Copyright © 2019 Ibbi Khan. All rights reserved.
//

import UIKit

class ChatsCell: UITableViewCell {

    @IBOutlet weak var userDp: UIImageView!
    @IBOutlet weak var userName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
