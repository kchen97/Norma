//
//  ChatBotViewController.swift
//  Norma
//
//  Created by Tim Roesner on 2/17/18.
//  Copyright © 2018 Korman Chen. All rights reserved.
//

import UIKit

class ChatBotViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var intentLabel: UILabel!
    @IBOutlet weak var actionBtn: UIButton!
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        intentLabel.text = "Lorem ipsum dolo sore est. Just some basic sample text to see if line wrapping is working"
        actionBtn.layer.cornerRadius = 18
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 25
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "queryCell") as! ChatBotTableViewCell
        var normaTalks = true
        
        if(normaTalks) {
            cell.rightSpacing.constant = screenWidth*0.25
        } else {
            cell.leftSpacing.constant = screenWidth*0.25
        }
        cell.label.text = "Lorem ipsum dolo sore est. Just some basic sample text to see if line wrapping is working"
        //cell.label.text = "Hi this is Norma"
        return cell
    }

}
