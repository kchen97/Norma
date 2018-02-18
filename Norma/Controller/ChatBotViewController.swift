//
//  ChatBotViewController.swift
//  Norma
//
//  Created by Tim Roesner on 2/17/18.
//  Copyright © 2018 Korman Chen. All rights reserved.
//

import UIKit
import HoundifySDK
import FirebaseDatabase

class ChatBotViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var intentLabel: UILabel!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var actionBtn1: UIButton!
    @IBOutlet weak var actionBtn2: UIButton!
    @IBOutlet weak var actionBtn3: UIButton!
    @IBOutlet weak var tableView: UITableView!

    var queries = [Query]()
    var username = ""
    var firstTime = true
    var ref : DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        startingValues()
        tableView.tableFooterView = UIView.init(frame: CGRect.zero)
        
        ref = Database.database().reference()
        
        for button in stackView.arrangedSubviews {
            button.layer.cornerRadius = 12
        }
    }
    
    func startingValues() {
        if(firstTime) {
            queries.append(Query("Hi, I'm Norma", normaTalks: true))
            intentLabel.text = "Pick an option from below"
            actionBtn1.setTitle("Hello", for: .normal)
            actionBtn2.isHidden = true
            actionBtn3.isHidden = true
        } else {
            queries.append(Query("Welcome back", normaTalks: true))
            intentLabel.text = "Pick an option from below"
            actionBtn1.setTitle("Mirror", for: .normal)
            actionBtn2.setTitle("Standing in the shower", for: .normal)
            actionBtn3.setTitle("Lying down", for: .normal)
        }
    }
    
    @IBAction func actionSelected(_ sender: UIButton) {
        let action = sender.currentTitle ?? ""
        if(action == "Rebecca" || action == "Pooja" || action == "Susan") {
            username = action
            //ref.child(currentUser.uid)
            queries.append(Query(action, normaTalks: false))
            tableView.reloadData()
            sendActionRequest(action)
        } else if(action == "Let me tell a friend") {
            let textToShare = "I found this great App called Norma, you should check it out!"
            if let myWebsite = NSURL(string: "https://appsite.skygear.io/norma/") {
                let objectsToShare = [textToShare, myWebsite] as [Any]
                let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
                activityVC.popoverPresentationController?.sourceView = sender
                self.present(activityVC, animated: true, completion: nil)
            }
        } else if(action == "Calling provider: 555 636 1982") {
            UIApplication.shared.open(URL(string: "tel://5556361982")!)
        } else if(action == "Ok thank you Norma!") {
            self.dismiss(animated: true, completion: nil)
        } else {
            queries.append(Query(action, normaTalks: false))
            tableView.reloadData()
            sendActionRequest(action)
        }
    }
    
    @IBAction func home() {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "home")
        self.present(vc!, animated: true, completion: nil)
    }
    
    @IBAction func profile() {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "profile")
        self.present(vc!, animated: true, completion: nil)
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
        
        let json = dict["AllResults"] as? [[String:Any]]
        let choices = json?[0]["Result"] as? [String] ?? ["Error"]
        var response = json?[0]["SpokenResponse"] as? String ?? "Error"
        
        if(response.contains("*user_name*")) {
            response = response.replacingOccurrences(of: "*user_name*", with: username)
        }
        
        queries.append(Query(response, normaTalks: true))
        
        for i in 0...2 {
            let btn = stackView.arrangedSubviews[i] as? UIButton
            if let choice = choices[safe: i] {
                btn?.setTitle(choice, for: .normal)
                btn?.isHidden = false
            } else {
                btn?.isHidden = true
            }
        }
        tableView.reloadData()
        scrollToBottom(animated: true)
    }
    
    func scrollToBottom(animated: Bool) {
        DispatchQueue.main.async {
            let index = IndexPath(row: self.queries.count-1, section: 0)
            self.tableView.scrollToRow(at: index, at: .top, animated: animated)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return queries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "queryCell") as! ChatBotTableViewCell
        let query = queries[indexPath.row]
        
        if(query.normaTalks) {
            cell.rightSpacing.constant = screenWidth*0.25
            cell.leftSpacing.constant = 8
            cell.backView.backgroundColor = #colorLiteral(red: 0.8823529412, green: 0.8784313725, blue: 0.9137254902, alpha: 1)
        } else {
            cell.leftSpacing.constant = screenWidth*0.25
            cell.rightSpacing.constant = 8
            cell.backView.backgroundColor = #colorLiteral(red: 0.968627451, green: 0.7725490196, blue: 0.9960784314, alpha: 1)
        }
        cell.label.text = query.text
        return cell
    }

}
