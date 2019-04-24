//
//  LunchViewFooter.swift
//  Lunch Mama
//
//  Created by 湯海彬 on 24/4/2019.
//  Copyright © 2019 binaryyard. All rights reserved.
//

import UIKit

class LunchViewFooter: UICollectionReusableView {
    @IBAction func submit_new_record(_ sender: UIButton){
        print("hi from submit button")
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "submit new record"), object: self)
    }
    
}
