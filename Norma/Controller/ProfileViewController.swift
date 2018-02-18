//
//  ProfileViewController.swift
//  Norma
//
//  Created by Tim Roesner on 2/17/18.
//  Copyright © 2018 Korman Chen. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var name: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        name.layer.cornerRadius = 30
        name.layer.borderWidth = 3
        name.layer.borderColor = UIColor.white.cgColor
    }
}
