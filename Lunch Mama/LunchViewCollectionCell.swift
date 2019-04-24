//
//  LunchViewCollectionCellCollectionViewCell.swift
//  Lunch Mama
//
//  Created by 湯海彬 on 5/4/2019.
//  Copyright © 2019 binaryyard. All rights reserved.
//

import UIKit

class LunchViewCollectionCellCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var my_label: UILabel!
    @IBOutlet weak var lunch_status_label: UILabel!
    
    @IBAction func Edit_Lunch_Comsumption(_ sender: UIButton) {
        print("mylog: Edit Btton pressed.")
        let sb = UIStoryboard(name: "LunchCellPopup", bundle: nil)
        let popup = sb.instantiateInitialViewController()! as! LunchCellPopupViewController
        popup.student_email = my_label.text ?? "default value from cell VC"
        self.window?.rootViewController?.present(popup, animated: true, completion: nil)
    }
    
}
