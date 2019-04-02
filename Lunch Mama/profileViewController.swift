//
//  profileViewController.swift
//  Lunch Mama
//
//  Created by 湯銳彬 on 30/3/2019.
//  Copyright © 2019 binaryyard. All rights reserved.
//

import UIKit
import Firebase
import FirebaseFirestore

class profileViewController: UIViewController {
    var db: Firestore!
    var doc_ref: DocumentReference!

    @IBOutlet weak var user_name_label: UILabel!
    
    @IBAction func signOutPressed(_ sender: Any) {
        try! Auth.auth().signOut()
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let loginViewController  = self.storyboard?.instantiateViewController(withIdentifier: "loginPage")
        appDelegate.window?.rootViewController = loginViewController
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //setting up firebase db connection
        let settings = FirestoreSettings()
        Firestore.firestore().settings = settings
        let id = (Auth.auth().currentUser?.uid ?? "0")
        print("user_infos/\(id)")
        doc_ref = Firestore.firestore().document("user_infos/\(id)")
        doc_ref.getDocument { (document, error) in
            guard let document = document, document.exists else { return }
            let name = document.data()?["name"] as? String
            self.user_name_label.text = name
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
