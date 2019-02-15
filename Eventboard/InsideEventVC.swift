//
//  InsideEventVC.swift
//  Eventboard
//
//  Created by Patrick Li on 2/10/19.
//  Copyright © 2019 Patrick Li. All rights reserved.
//

import UIKit

class EventTableViewCell: UITableViewCell {
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var bodytext: UILabel!
    
}

class InsideEventVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
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
    
    @IBOutlet weak var eventImage: UIImageView!
    @IBOutlet weak var eventTitle: UILabel!
    @IBOutlet weak var eventDescription: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //self.tableView.delegate = self
        //self.tableView.dataSource = self
        
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
    }
    
}
