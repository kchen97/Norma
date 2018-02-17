//
//  NormaViewController.swift
//  Norma
//
//  Created by Korman Chen on 2/16/18.
//  Copyright © 2018 Korman Chen. All rights reserved.
//

import UIKit
import Firebase

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

                self.saveJournal()
                self.readJournal()

            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    //MARK: Reading and Writing from Firebase
    func saveJournal() {
        
        ref.setValue(["january" : "test test test"])
    }
    
    func readJournal() {
        
        ref.observe(.value) { (snapshot) in
            
            if let journalDict = snapshot.value as? NSDictionary {
                self.currentUser.journal = journalDict["january"] as? String
            }
        }
    }
    
    //MARK: Actions
    
}
