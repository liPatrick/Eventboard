//
//  InsideEventVC.swift
//  Eventboard
//
//  Created by Patrick Li on 2/10/19.
//  Copyright © 2019 Patrick Li. All rights reserved.
//

import UIKit
import Firebase

class EventTableViewCell: UITableViewCell {
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var bodytext: UILabel!
    
}

class InsideEventVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var eventImage: UIImageView!
    @IBOutlet weak var eventTitle: UILabel!
    @IBOutlet weak var eventDescription: UILabel!
    
    
    let db = Firestore.firestore()
    var postList: [PostObject]!
    var eventObject: EventObject!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // load data from firebase later
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EventTableViewCell", for: indexPath)
            as! EventTableViewCell
        cell.title.font = UIFont(name: "Quicksand-Bold", size: 15)
        cell.bodytext.font = UIFont(name: "Quicksand-Light", size: 12)
        cell.bodytext.text = "Email: danielbess16@gmail.com\nPhone: 4087969033\nWebsite: www.google.com"
        cell.bodytext.textColor = UIColor(red: 0.14, green: 0.14, blue: 0.14, alpha: 1)
        cell.cardView.layer.shadowColor = UIColor(red: 0.12, green: 0.13, blue: 0.25, alpha: 0.12).cgColor
        cell.cardView.layer.shadowOpacity = 1
        cell.cardView.layer.shadowOffset = CGSize.zero
        cell.cardView.layer.shadowRadius = 5
        return cell
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //image gradient
        let colorLeft = UIColor(red: 0.12, green: 0.13, blue: 0.25, alpha: 1).cgColor
        let colorRight = UIColor(red: 0.12, green: 0.13, blue: 0.25, alpha: 0.05).cgColor
        let view = UIView(frame: eventImage.frame)
        let gl = CAGradientLayer()
        gl.frame = view.frame
        gl.colors = [colorLeft, colorRight]
        gl.startPoint = CGPoint(x: 0.0, y: 0.5)
        gl.endPoint = CGPoint(x: 1.0, y: 0.5)
        view.layer.insertSublayer(gl, at: 0)
        eventImage.addSubview(view)
        eventImage.bringSubviewToFront(view)
        
        //setup
        self.eventTitle.font = UIFont(name: "Quicksand-Bold", size: 32)
        self.eventDescription.font = UIFont(name: "Quicksand-Regular", size: 18)
        
        //firebase loading
        self.postList = []
        
        getEvent(eventID: "2TWmP8KcfbF48uC7SKQ7")
    }
    
    func getEvent(eventID: String){
        let docRef = db.collection("events").document(eventID)
        
        docRef.collection("posts").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    let data = document.data()
                    let post_creator_id = data["post_creator_id"] as! String
                    let date_created = data["date_created"] as! String
                    let post_text = data["post_text"] as! String
                    let post_title = data["post_title"] as! String
                    let object = PostObject(creator_id: post_creator_id, title: post_title, text: post_text, date_created: date_created)
                    print("looki")
                    self.postList.append(object)
                    
                }
            }
            
        }

    }
    
}
