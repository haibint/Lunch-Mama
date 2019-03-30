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

    
    @IBAction func signOutPressed(_ sender: Any) {
        try! Auth.auth().signOut()
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let loginViewController  = self.storyboard?.instantiateViewController(withIdentifier: "loginPage")
        appDelegate.window?.rootViewController = loginViewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
