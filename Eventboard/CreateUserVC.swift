//
//  CreateUserVC.swift
//  Eventboard
//
//  Created by Patrick Li on 2/18/19.
//  Copyright © 2019 Patrick Li. All rights reserved.
//

import UIKit
import Firebase

class UserObject{
    var event_id_list: [String]
    var username: String
    
    init(event_id_list: [String], username:
        String) {
        self.event_id_list = event_id_list
        self.username = username
    }
}

class CreateUserVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func createNewUserButtonPressed(_ sender: Any) {
        //will update once we incldue facebook because I'm not sure exactly how fb user auth will add. 
    }
}
