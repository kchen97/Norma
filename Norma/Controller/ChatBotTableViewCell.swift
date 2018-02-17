//
//  ChatBotTableViewCell.swift
//  Norma
//
//  Created by Tim Roesner on 2/17/18.
//  Copyright © 2018 Korman Chen. All rights reserved.
//

import UIKit

class ChatBotTableViewCell: UITableViewCell {
    
    @IBOutlet weak var query: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        query.backgroundColor = UIColor.blue
        query.layer.cornerRadius = 15
    }

}
