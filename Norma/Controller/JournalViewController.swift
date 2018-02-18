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

var currentUser = User()

class JournalViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    

    //MARK: Properties
    @IBOutlet weak var journalTableView: UITableView!
    var ref : DatabaseReference!
    var month : String?
    var year : String?
    var entry : String?
    var entryArray = [JournalEntry]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
        Auth.auth().signInAnonymously { (user, error) in

            if let id = user?.uid {
                currentUser.userID = id
                self.ref = Database.database().reference().child(id)
                
                self.ref.updateChildValues(["\(Calendar.current.component(.month, from: Date()))" : ["\(Calendar.current.component(.year, from: Date()))" : "Test Test TEst"]])
            
                print(currentUser.userID)
                
                self.readJournal()
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    //MARK: UI Setup
    func setupUI() {
        journalTableView.delegate = self
        journalTableView.dataSource = self
    }
    
    //MARK: Reading from Firebase
    func readJournal() {
        
        ref.observe(.value) { (snapshot) in
            
            self.entryArray.removeAll()
            if let journalDict = snapshot.value as? NSDictionary {
                print(journalDict)
                if let monthKeys = journalDict.allKeys as? [String] {
                    print(monthKeys)
                    for month in monthKeys {
                        if let yearDictionary = journalDict[month] as? NSDictionary {
                            if let yearKeys = yearDictionary.allKeys as? [String] {
                                print(yearKeys)
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
        print(correspondingJournalEntry.month)
        let cell = tableView.dequeueReusableCell(withIdentifier: "entryCell") as? UITableViewCell

        cell?.textLabel?.text = correspondingJournalEntry.month! + "/" + correspondingJournalEntry.year!
        cell?.detailTextLabel?.text = correspondingJournalEntry.entry
        print(cell)

        return cell!
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
