//
//  CreatePostVC.swift
//  Eventboard
//
//  Created by Patrick Li on 2/18/19.
//  Copyright © 2019 Patrick Li. All rights reserved.
//

import UIKit
import Firebase

class PostObject{
    //var post_id: String
    var post_creator_id: String
    var post_title: String
    var post_text: String
    var date_created: NSDate
    
    init(creator_id: String, title: String, text: String, date_created: NSDate) {
        self.post_creator_id = creator_id
        self.post_title = title
        self.post_text = text
        self.date_created = date_created
    }
}

class CreatePostVC: UIViewController {
    
    let db = Firestore.firestore()

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func createPostButtonPressed(_ sender: Any) {
        var post_creator_id: String = "thisisdefaultid" //get from current user
        var post_title: String = "default title" //get from text field
        var post_text: String = "default text: blockchain with neural net capatbilites are awesome and also we serve chocolates"
        var date_created: NSDate = NSDate()
        
        let docData: [String: Any] = [
            "post_creator_id": post_creator_id,
            "post_title": post_title,
            "post_text": post_text,
            "date_created": date_created
        ]
        
        var eventID: String = "2TWmP8KcfbF48uC7SKQ7" //this is a default id
        db.collection("events").document(eventID).collection("posts").addDocument(data: docData) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }
        
    }
}
