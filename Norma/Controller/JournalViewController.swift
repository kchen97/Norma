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
    var selectedEntry : JournalEntry?
    var entryArray = [JournalEntry]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        setupUI()
        
//        Auth.auth().signInAnonymously { (user, error) in
//            if let id = user?.uid {
//                currentUser.userID = id
//
//            }
//        }
        
        if let user = Auth.auth().currentUser {
            self.ref = Database.database().reference().child(user.uid)
            //self.ref.updateChildValues(["\(Calendar.current.component(.year, from: Date()))" : "Test"])
            self.readJournal()
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
                if let dateKeys = journalDict.allKeys as? [String] {
                    for dateString in dateKeys {
                        let someEntry = JournalEntry(self.convertStringToDate(dateString), journalDict[dateString] as! String)
                        self.entryArray.append(someEntry)
                    }
                }
                
            }
            
            self.entryArray.sorted(by: { $0.date.compare($1.date) == .orderedAscending })
            
            self.journalTableView.reloadData()
            
        }
    }
    
    //MARK: Delegates
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        return entryArray.count
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let correspondingJournalEntry = entryArray[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "entryCell")
        
        
        cell?.textLabel?.text = correspondingJournalEntry.convertDateToString(.pretty)
        cell?.detailTextLabel?.text = correspondingJournalEntry.entry
        

        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.selectedEntry = entryArray[indexPath.row]
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        performSegue(withIdentifier: "showNotes", sender: self)
    }
    
    //MARK: Segues
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "showNotes" {
            if let destination = segue.destination as? EntryViewController {
                destination.selectedEntry = self.selectedEntry
            }
        }
    }
    
    
    func convertStringToDate(_ dateString : String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM-dd-yyyy" //Your date format
        let newDate = dateFormatter.date(from: dateString) //according to date format your date string
        
        return newDate!
    }
}
