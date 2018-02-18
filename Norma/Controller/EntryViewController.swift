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
    var month : String?
    var year : String?
    var entry : String?
    var ref = Database.database().reference().child((Auth.auth().currentUser?.uid)!)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadEntryUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }
    
    //MARK: UI Setup
    func loadEntryUI() {
        
        if let m = month, let y = year, let e = entry {
            
            navigationItem.title = m + "/" + y
            notesTextView.text = e
        }
        
        notesTextView.backgroundColor = UIColor.yellow
        notesTextView.layer.cornerRadius = 12
    }
    
    //MARK: Actions
    @IBAction func savePressed(_ sender: UIBarButtonItem) {
        
        if let m = month, let y = year, !notesTextView.text.isEmpty {
            self.entry = notesTextView.text
            saveJournal(m, y, entry!)
        }
    }
    
    func saveJournal(_ month: String, _ year: String, _ entry: String) {
        
        print(month, year, entry)
        
        ref.child(month).updateChildValues([year : entry])
        
        navigationController?.popViewController(animated: true)
    }
}
