//
//  NormaViewController.swift
//  Norma
//
//  Created by Korman Chen on 2/16/18.
//  Copyright © 2018 Korman Chen. All rights reserved.
//

import UIKit
import Firebase

class ChatBotViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var queries = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  25 //queries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "chatBubble") as! ChatBotTableViewCell
        cell.query.text = "This is some sample text. Lorem impsum dolo sore est"
        return cell
    }

}
