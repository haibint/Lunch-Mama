//
//  profileViewController.swift
//  Lunch Mama
//
//  Created by 湯銳彬 on 30/3/2019.
//  Copyright © 2019 binaryyard. All rights reserved.
//

import UIKit
import Firebase

class profileViewController: UIViewController {
    var db: Firestore!

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
        db = Firestore.firestore()
        
        print("mylog:" + Auth.auth().currentUser!.uid)
        let doc_ref = db.collection("user_infos").document("oFV4XpcYRbTCshj7vakH6Fjy36y1")
        doc_ref.getDocument { (document, error) in
            self.user_name_label.text = document!.data()!["name"] as? String
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
