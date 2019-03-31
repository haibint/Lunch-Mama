//
//  latestNewsViewController.swift
//  Lunch Mama
//
//  Created by 湯銳彬 on 29/3/2019.
//  Copyright © 2019 binaryyard. All rights reserved.
//

import UIKit
import Firebase
import FirebaseFirestore
struct News {
    var date:Timestamp?
    var author:String?
    var title:String?
    var lead:String?
    var content:String?
}

class latestNewsViewController: UIViewController, UITableViewDataSource {
    var db: Firestore!
    var numberOfNewsRows: Int = 0
    var newsArray = [News]()
    
    @IBOutlet weak var lastestnewTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let settings = FirestoreSettings()
        Firestore.firestore().settings = settings
        //[end setup]
        db = Firestore.firestore()
        getCollection()
        
    }
    
    
    private func getCollection() {
        //get the latest five entries in news
        print("mylog: getcollection() called")
        db.collection("news").order(by: "date", descending:true).limit(to: 5)
            .getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    for document in querySnapshot!.documents {
                        let news = News(date: document.data()["date"] as! Timestamp?, author: document.data()["author"] as! String?, title: document.data()["title"] as! String?, lead: document.data()["lead"] as! String?, content: document.data()["content"] as! String?)
                        print("mylog: \(news)")
                        self.newsArray.append(news)
                    }
                    self.numberOfNewsRows = self.newsArray.count
                    self.lastestnewTable.reloadData()
                }
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.numberOfNewsRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = newsArray[indexPath.row].title
        return cell
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
