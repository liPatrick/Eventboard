//
//  InsideEventVC.swift
//  Eventboard
//
//  Created by Patrick Li on 2/10/19.
//  Copyright © 2019 Patrick Li. All rights reserved.
//

import UIKit

class EventTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var label: UILabel!
    
    
    
}

class InsideEventVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 2
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EventTableViewCell", for: indexPath)
            as! EventTableViewCell
        
        cell.label.text = "here"
        
        return cell
        
    }
    
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
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
        
        
        
        
        
        
        
  

        
        
   
        // Do any additional setup after loading the view.
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
