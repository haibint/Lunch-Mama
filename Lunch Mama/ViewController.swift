//
//  ViewController.swift
//  Lunch Mama
//
//  Created by 湯銳彬 on 28/3/2019.
//  Copyright © 2019 binaryyard. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController {
    
    
    @IBOutlet weak var loginID: UITextField!
    @IBOutlet weak var loginPW: UITextField!

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    //change login role image
    @IBOutlet weak var currentLoginRoleIcon: UIImageView!
    @IBAction func loginRoleControl(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0: //student
            currentLoginRoleIcon.image = UIImage(named: "loginstudent")
            break
        case 1: //staff
            currentLoginRoleIcon.image = UIImage(named: "loginteacher")
            break
        case 2: //admin
            currentLoginRoleIcon.image = UIImage(named: "loginadmin")
            break
        default:
            currentLoginRoleIcon.image = UIImage(named: "loginpic")
            break
        }
    }
    
    func showMessagePrompt(msg: String!){
            print(msg)
    }
    
    func loginVerify (id: String!, pw: String!)->Bool {
        var success = false
        Auth.auth().signIn(withEmail: id, password: pw) { [weak self] user, error in
            if error == nil {
                success = true
            }
            guard let strongSelf = self else { return }
        }
        return success
    }
    //submir login info
    @IBAction func loginSubmitted(_ sender: UIButton) {
        //resign first responder while submit
        self.loginID.resignFirstResponder()
        self.loginPW.resignFirstResponder()
        
        guard let email = self.loginID.text, let password = self.loginPW.text else {
            self.showMessagePrompt(msg: "郵箱或帳號不能為空")
            return
        }
        
        if loginVerify(id: email, pw: password) {
            //change tab bar view as root view controller after successful login
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let tabBarViewController  = self.storyboard?.instantiateViewController(withIdentifier: "tabBar") as! UITabBarController
            appDelegate.window?.rootViewController = tabBarViewController
        } else {
            loginID.text = ""
            loginPW.text = ""
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    var authHandle: AuthStateDidChangeListenerHandle?
    override func viewWillAppear(_ animated: Bool) {
        authHandle = Auth.auth().addStateDidChangeListener {(auth, user) in
            //
            let user = Auth.auth().currentUser
            if let user = user {
                let uid = user.uid
                let email = user.email
                // ...
                print(uid)
            }
        }
    }
    override func viewWillDisappear(_ animated: Bool) {
        Auth.auth().removeStateDidChangeListener(authHandle!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

