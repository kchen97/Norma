//
//  HomeViewController.swift
//  Norma
//
//  Created by Tim Roesner on 2/17/18.
//  Copyright © 2018 Korman Chen. All rights reserved.
//

import UIKit
import SafariServices

class HomeViewController: UIViewController {
    
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var journalView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()

        topView.layer.borderColor = UIColor.white.cgColor
        topView.layer.borderWidth = 3
        topView.layer.cornerRadius = 30
        
        journalView.layer.borderColor = UIColor.white.cgColor
        journalView.layer.borderWidth = 3
        journalView.layer.cornerRadius = 25
    }
    
    @IBAction func whatsTheNorm() {
        let svc = SFSafariViewController(url: URL(string: "http://www.nationalbreastcancer.org/breast-self-exam")!)
        self.present(svc, animated: true, completion: nil)
    }
    
    @IBAction func checkTheNorm() {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "chatBot") as! ChatBotViewController
        vc.firstTime = false
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func shareTheNorm(_ sender: UIButton) {
        let textToShare = "I found this great App called Norma, you should check it out!"
        if let myWebsite = NSURL(string: "https://appsite.skygear.io/norma/") {
            let objectsToShare = [textToShare, myWebsite] as [Any]
            let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
            activityVC.popoverPresentationController?.sourceView = sender
            self.present(activityVC, animated: true, completion: nil)
        }
    }
    
    @IBAction func journalBtn() {
        
    }
    
    @IBAction func profileBtn() {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "profile")
        self.present(vc!, animated: true, completion: nil)
    }
    

}
