//
//  ViewController.swift
//  Lunch Mama
//
//  Created by 湯銳彬 on 28/3/2019.
//  Copyright © 2019 binaryyard. All rights reserved.
//
import UIKit
import Firebase
import FirebaseFirestore

class ViewController: UIViewController {
    var db: Firestore!
    
    @IBOutlet weak var loginID: UITextField!
    @IBOutlet weak var loginPW: UITextField!
    
    @IBOutlet weak var accountLabel: UILabel!
    @IBOutlet weak var passwordLabel: UILabel!
    
    @IBOutlet weak var signUpSubmitButton: UIButton!
    var isSigningUp = false
    
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
    
    func loginSignupSwitchTo(status:String!){
        switch status {
        case "login":
            self.accountLabel.text = "登入戶口"
            self.passwordLabel.text = "密碼"
            self.isSigningUp = false
            self.signUpSubmitButton.isHidden = true
            self.signUpSubmitButton.isEnabled = false
            break
        case "signup":
            self.accountLabel.text = "輸入電郵"
            self.passwordLabel.text = "輸入密碼"
            self.isSigningUp = true
            self.signUpSubmitButton.isHidden = false
            self.signUpSubmitButton.isEnabled = true
            break
        default:
            break
        }
    }
    
    @IBAction func signUpPressed(_ sender: Any) {
        if isSigningUp {return} else {loginSignupSwitchTo(status: "signup")}
    }
    
    @IBAction func signUpSubmit(_ sender: Any) {
        guard let email = self.loginID.text, let password = self.loginPW.text else {return}
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if authResult?.user != nil {
                //switch back to login after successful signup
                self.loginSignupSwitchTo(status: "login")
                self.loginID?.text = authResult?.user.email
                self.loginPW?.text = ""
                // add newly signup users into the database
                self.db.collection("user_infos").document(authResult!.user.uid).setData([
                    "name": authResult!.user.email!,
                    "email": authResult!.user.email!
                    //...
                ]){ err in
                    if let err = err {
                        print("Error writing document: \(err)")
                    } else {
                        print("Document successfully written!")
                    }
                }
            }
        }
    }
    
    //submib login info
    @IBAction func loginSubmitted(_ sender: UIButton) {
        //switch back to login view
        if isSigningUp {
            loginSignupSwitchTo(status: "login")
            return
        }
        //resign first responder while submit
        self.loginID.resignFirstResponder()
        self.loginPW.resignFirstResponder()
        
        //login verfity
        guard let email = self.loginID.text, let password = self.loginPW.text else {return}
        
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] user, error in
            guard let strongSelf = self else { return }
            if user == nil {
                strongSelf.loginID?.text = ""
                strongSelf.loginPW?.text = ""
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let settings = FirestoreSettings()
        Firestore.firestore().settings = settings
        
        db = Firestore.firestore()
    }
    var authHandle: AuthStateDidChangeListenerHandle?
    override func viewWillAppear(_ animated: Bool) {
        authHandle = Auth.auth().addStateDidChangeListener {(auth, user) in
            //
            let user = Auth.auth().currentUser
            if user != nil {
                //change tab bar view as root view controller after successful login
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                let tabBarViewController  = self.storyboard?.instantiateViewController(withIdentifier: "tabBar") as! UITabBarController
                appDelegate.window?.rootViewController = tabBarViewController
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
