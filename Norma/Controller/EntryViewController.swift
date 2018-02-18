//
//  EntryViewController.swift
//  Norma
//
//  Created by Korman Chen on 2/17/18.
//  Copyright © 2018 Korman Chen. All rights reserved.
//

import UIKit
import Firebase

class EntryViewController: UIViewController {

    //MARK: Properties
    @IBOutlet weak var notesTextView: UITextView!
    var selectedEntry : JournalEntry?
    var ref = Database.database().reference().child((Auth.auth().currentUser?.uid)!)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.isNavigationBarHidden = false
        loadEntryUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }
    
    //MARK: UI Setup
    func loadEntryUI() {
        
        if let sEntry = selectedEntry {
            
            navigationItem.title = sEntry.convertDateToString(.pretty)
            notesTextView.text = sEntry.entry
        }
        
        notesTextView.backgroundColor = UIColor.white
        notesTextView.layer.cornerRadius = 12
    }
    
    //MARK: Actions
    @IBAction func savePressed(_ sender: UIBarButtonItem) {
        
        if let selEntry = selectedEntry, !notesTextView.text.isEmpty {
            selEntry.entry = notesTextView.text
            saveJournal(selEntry)
        }
    }
    
    func saveJournal(_ entry: JournalEntry) {
        
        ref.updateChildValues([entry.convertDateToString(.ugly) : entry.entry])
        
        navigationController?.popViewController(animated: true)
    }
}
