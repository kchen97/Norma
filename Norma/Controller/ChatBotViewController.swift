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
    @IBOutlet weak var actionBtn1: UIButton!
    @IBOutlet weak var actionBtn2: UIButton!
    @IBOutlet weak var actionBtn3: UIButton!
    @IBOutlet weak var tableView: UITableView!

    var queries = [Query]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        startingValues()
        actionBtn1.layer.cornerRadius = 12
        actionBtn2.layer.cornerRadius = 12
        actionBtn3.layer.cornerRadius = 12
    }
    
    func startingValues() {
        queries.append(Query("Hi, I'm Norma", normaTalks: true))
        intentLabel.text = "What would you like to do"
        actionBtn1.setTitle("Start my monthly check", for: .normal)
        actionBtn3.setTitle("Button 3", for: .normal)
        actionBtn2.isHidden = true
    }
    
    @IBAction func actionSelected(_ sender: UIButton) {
        let action = sender.currentTitle ?? ""
        queries.append(Query(action, normaTalks: false))
        tableView.reloadData()
        sendActionRequest(action)
    }
    
    @IBAction func home() {
        
    }
    
    @IBAction func profile() {
        
    }
    
    func sendActionRequest(_ action: String) {
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return queries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "queryCell") as! ChatBotTableViewCell
        let query = queries[indexPath.row]
        
        if(query.normaTalks) {
            cell.rightSpacing.constant = screenWidth*0.25
            cell.backView.backgroundColor = UIColor.blue
        } else {
            cell.leftSpacing.constant = screenWidth*0.25
            cell.backView.backgroundColor = UIColor.lightGray
        }
        cell.label.text = query.text
        return cell
    }

}
