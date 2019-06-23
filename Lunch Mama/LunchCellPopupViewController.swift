//
//  LunchCellPopupViewController.swift
//  Lunch Mama
//
//  Created by 湯海彬 on 15/4/2019.
//  Copyright © 2019 binaryyard. All rights reserved.
//

import UIKit

class LunchCellPopupViewController: UIViewController {
    
    //this obejct's student_id should come from cell that calls it rather than hard coded.
    var student_email = "default from popup VC"
    var student_lunch_status = "just right"

    override func viewDidLoad() {
        super.viewDidLoad()
        print("mylog: \(student_email)")
        // Do any additional setup after loading the view.
    }
    
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func option1_clicked(_ sender: Any) {
        self.student_lunch_status = "1/4 Food Left"
        dismiss(animated: true)
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "food_change"), object: self)
    }
    
    @IBAction func option2_clicked(_ sender: Any) {
        self.student_lunch_status = "1/2 Food Left"
        dismiss(animated: true)
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "food_change"), object: self)
    }
    
    @IBAction func option3_clicked(_ sender: Any) {
        self.student_lunch_status = "3/4 Food Left"
        dismiss(animated: true)
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "food_change"), object: self)
    }
    
    @IBAction func option4_clicked(_ sender: Any) {
        self.student_lunch_status = "Didn't eat at all"
        dismiss(animated: true)
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "food_change"), object: self)
    }
    
    @IBAction func option5_clicked(_ sender: Any) {
        self.student_lunch_status = "MoreFood!"
        dismiss(animated: true)
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "food_change"), object: self)
    }
    
    
    @IBAction func to_just_right(_ sender: Any) {
        self.student_lunch_status = "just right"
        dismiss(animated: true)
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "food_change"), object: self)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
