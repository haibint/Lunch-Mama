//
//  LunchViewController.swift
//  Lunch Mama
//
//  Created by 湯海彬 on 2/4/2019.
//  Copyright © 2019 binaryyard. All rights reserved.
//

import UIKit
import Firebase
import FirebaseFirestore

struct StudentRecord {
    var student_email:String?
    var date:Timestamp?
    var lunch_status:String?
    
}

//UIViewController, UICollectionViewDataSource, UICollectionViewDelegate
class LunchViewController: UICollectionViewController {
    
    let cell_reuseIdentifier = "cell"
    let footer_reuseIdentifier = "LunchViewFooter"
    var db: Firestore!
    var image_names = ["01", "02", "03", "04", "05", "06", "07", "08", "09", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23", "24"]
//    var student_lunch_consumptions = ["just right", "just right", "just right"]
    var student_record_array = [StudentRecord]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let settings = FirestoreSettings()
        Firestore.firestore().settings = settings
        db = Firestore.firestore()
        load_studetns()
        
        NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: "food_change"), object: nil, queue: OperationQueue.main) { (notification) in
            let popupVC = notification.object as! LunchCellPopupViewController
            print("mylog: an update on lunch status detected \(popupVC.student_email) \(popupVC.student_lunch_status)")
            
            //finding out the index to change
            let index_to_update = self.student_record_array.indices.filter { self.student_record_array[$0].student_email == popupVC.student_email}
            
            //changing lunch_status for the student
            self.student_record_array[index_to_update[0]].lunch_status = popupVC.student_lunch_status
            
            //perform a reload here.
            self.collectionView?.reloadData()
        }
        
        NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: "submit new record"), object: nil, queue: OperationQueue.main) { (notification) in
            // add a for loop through student_lunch_consumption array
            for a_record in self.student_record_array {
                self.db.collection("records").addDocument(data:[
                    "Class":"testing class",
                    "date": Timestamp(),
                    "food_consumption":a_record.lunch_status ?? "input error",
                    "student_email":a_record.student_email ?? "input error"
                ] ){ err in
                    if let err = err {
                        print("Error writing document: \(err)")
                        let alert = UIAlertController(title: "Feedback", message: "There was an error \(err)", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                        self.present(alert, animated: true)
                    } else {
                        print("Document successfully written!")
                        let alert = UIAlertController(title: "Feedback", message: "Document successfully written!", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                        self.present(alert, animated: true)
                    }
                }
            }
        }
    }
    
    
    // tell the collection view how many cells to make
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.student_record_array.count
    }
    
    // make a cell for each cell index path
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // get a reference to our storyboard cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cell_reuseIdentifier, for: indexPath as IndexPath) as! LunchViewCollectionCellCollectionViewCell
        
        // Use the outlet in our custom class to get a reference to the UILabel in the cell
        cell.my_label.text = self.student_record_array[indexPath.item].student_email
        cell.lunch_status_label.text = self.student_record_array[indexPath.item].lunch_status
//        cell.backgroundColor = UIColor.gray // make cell more visible in our example project
        cell.Icon_area.image = UIImage(named: image_names[indexPath.item])
        
        return cell
    }
    
    // adding the footer for submit button
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let footer_view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: footer_reuseIdentifier, for: indexPath) as! LunchViewFooter
        
        return footer_view
    }
    
    // MARK: - UICollectionViewDelegate protocol
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // handle tap events
        print("mylog: You selected cell #\(indexPath.item)!")
    }
    
    private func load_studetns() {
        print("load_student_log: getting student record")
        db.collection("user_infos").whereField("user_role", isEqualTo: 0)
            .getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("load_student_log:can't get documents: \(err)")
                } else {
                    for document in querySnapshot!.documents{
                        let a_student_record = StudentRecord(student_email: document.data()["email"] as! String?, date: Timestamp(), lunch_status: "just right")
                        self.student_record_array.append(a_student_record)
                    }
                    self.collectionView?.reloadData()
                    print("load students successfully.")
                }
        }
    }
}
