//
//  ChatBotViewController.swift
//  Norma
//
//  Created by Tim Roesner on 2/17/18.
//  Copyright © 2018 Korman Chen. All rights reserved.
//

import UIKit
import HoundifySDK
import SwiftyJSON

class ChatBotViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var intentLabel: UILabel!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var actionBtn1: UIButton!
    @IBOutlet weak var actionBtn2: UIButton!
    @IBOutlet weak var actionBtn3: UIButton!
    @IBOutlet weak var tableView: UITableView!

    var queries = [Query]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        startingValues()
        
        for button in stackView.arrangedSubviews {
            button.layer.cornerRadius = 12
        }
    }
    
    func startingValues() {
        queries.append(Query("Welcome back!", normaTalks: true))
        intentLabel.text = "What would you like to do"
        actionBtn1.setTitle("Hello", for: .normal)
        actionBtn2.isHidden = true
        actionBtn3.isHidden = true
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
        let requestInfoJSON: [String : Any] = ["StoredGlobalPagesToMatch":["pg1"]]
        
        HoundTextSearch.instance().search(withQuery: action, requestInfo: requestInfoJSON, completionHandler:
            { (error: Error?, myQuery: String, houndServer: HoundDataHoundServer?, dictionary: [String : Any]?, requestInfo: [String : Any]?) in
                if let error = error as NSError? {
                    print("\(error.domain) (\(error.code))\n\(error.localizedDescription)")
                } else if houndServer != nil, let dictionary = dictionary {
                    self.parseJSON(dictionary)
                }
            }
        )
    }
    
    func parseJSON(_ dict: [String:Any]) {
        let json = JSON(dict)
        let jsonClean = json["AllResults"]
        print(dict)
        //let response = jsonClean[SpokenResponseLong]
        //print(response)
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
