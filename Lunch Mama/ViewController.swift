//
//  ViewController.swift
//  Lunch Mama
//
//  Created by 湯銳彬 on 28/3/2019.
//  Copyright © 2019 binaryyard. All rights reserved.
//

import UIKit

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
    
    func loginVerify (id: String?, pw: String?)->Bool{
        var success = false
        if id == "admin" && pw == "123" {
            success = true
        }
        return success
    }
    //submir login info
    @IBAction func loginSubmitted(_ sender: UIButton) {
        //resign first responder while submit
        self.loginID.resignFirstResponder()
        self.loginPW.resignFirstResponder()
        
        if loginVerify(id: loginID.text, pw: loginPW.text) {
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

