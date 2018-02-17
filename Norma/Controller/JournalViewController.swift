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

class JournalViewController: UIViewController {

    //MARK: Properties
    var ref : DatabaseReference!
    var month : String?
    var currentUser = User()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Auth.auth().signInAnonymously { (user, error) in

            if let id = user?.uid {
                self.currentUser.userID = id
                self.ref = Database.database().reference().child((self.currentUser.userID)!)

                self.saveJournal("january", "1997", "test test test")
                self.readJournal("january", "1997")
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    //MARK: Reading and Writing from Firebase
    func saveJournal(_ month: String, _ year: String, _ entry: String) {
        
        ref.child(month).setValue([year : entry])
    }
    
    func readJournal(_ month: String, _ year: String) {
        
        ref.observe(.value) { (snapshot) in
            
            if let journalDict = snapshot.value as? NSDictionary {
                if let dict = journalDict[month] as? Dictionary<String, String> {
                    self.currentUser.journal = dict[year]
                    print(self.currentUser.journal)
                }
            }
        }
    }
    
    //MARK: Actions
    
}
