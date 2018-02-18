//
//  NormaViewController.swift
//  Norma
//
//  Created by Korman Chen on 2/16/18.
//  Copyright © 2018 Korman Chen. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class JournalViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    //MARK: Properties
    @IBOutlet weak var journalTableView: UITableView!
    @IBOutlet weak var journalNavBar: UINavigationBar!
    var ref : DatabaseReference!
    var month : String?
    var year : String?
    var entry : String?
    var entryArray = [JournalEntry]()
    var currentUser = User()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
        Auth.auth().signInAnonymously { (user, error) in

            if let id = user?.uid {
                self.currentUser.userID = id
                self.ref = Database.database().reference().child((self.currentUser.userID)!)
                
                self.readJournal()
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    //MARK: UI Setup
    func setupUI() {
        journalTableView.dataSource = self
        journalTableView.delegate = self
    }
    
    //MARK: Reading from Firebase
    func readJournal() {
        
        ref.observe(.value) { (snapshot) in
            
            if let journalDict = snapshot.value as? NSDictionary {
                if let monthKeys = journalDict.allKeys as? [String] {
                    for month in monthKeys {
                        if let yearDictionary = journalDict[month] as? NSDictionary {
                            if let yearKeys = yearDictionary.allKeys as? [String] {
                                for year in yearKeys {
                                    let text = yearDictionary[year] as? String ?? "error"
                                    self.entryArray.append(JournalEntry(month, year, text))
                                }
                            }
                        }
                    }
                }
            }
            
            self.journalTableView.reloadData()
        }
    }
    
    //MARK: Delegates
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return entryArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let correspondingJournalEntry = entryArray[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "journalEntryCell") as! UITableViewCell
        
        cell.textLabel?.text = "\((correspondingJournalEntry.month)?.capitalized ?? "error")" + " " + "\(correspondingJournalEntry.year ?? "error")"
        cell.detailTextLabel?.text = correspondingJournalEntry.entry
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.month = entryArray[indexPath.row].month
        self.year = entryArray[indexPath.row].year
        self.entry = entryArray[indexPath.row].entry
        
        performSegue(withIdentifier: "showNotes", sender: self)
    }
    
    //MARK: Segues
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "showNotes" {
            if let destination = segue.destination as? EntryViewController {
                destination.month = self.month!
                destination.year = self.year!
                destination.entry = self.entry
            }
        }
    }
}
