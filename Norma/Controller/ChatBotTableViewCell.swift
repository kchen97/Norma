//
//  ChatBotTableViewCell.swift
//  Norma
//
//  Created by Tim Roesner on 2/17/18.
//  Copyright © 2018 Korman Chen. All rights reserved.
//

import UIKit

class ChatBotTableViewCell: UITableViewCell {
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var rightSpacing: NSLayoutConstraint!
    @IBOutlet weak var leftSpacing: NSLayoutConstraint!

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        backView.layer.cornerRadius = 12
        label.textColor = UIColor.black
    }

}
