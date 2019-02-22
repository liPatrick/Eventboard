//
//  CardViewCell.swift
//  Eventboard
//
//  Created by Daniel Bessonov on 2/10/19.
//  Copyright © 2019 Patrick Li. All rights reserved.
//

import UIKit

class CardViewCell: UICollectionViewCell {
    
    @IBOutlet weak var image_view: UIImageView!
    @IBOutlet weak var summary_description: UILabel!
    @IBOutlet weak var summary_label: UILabel!
    @IBOutlet weak var more_info_button: UIButton!
    @IBOutlet weak var event_name: UILabel!
    @IBOutlet weak var id: UILabel!
    @IBOutlet weak var date: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // scale image proportionally
        image_view.contentMode = UIView.ContentMode.scaleAspectFill
        // make sure image doesn't go over bounds
        image_view.layer.masksToBounds = true
        // hardcore image for now
        image_view.image = UIImage(named: "coffee")
        // add gradient to image
        let color_left = UIColor(red: 0.12, green: 0.13, blue: 0.25, alpha: 1).cgColor
        let color_right = UIColor(red: 0.12, green: 0.13, blue: 0.25, alpha: 0.05).cgColor
        let view = UIView(frame: image_view.frame)
        let gl = CAGradientLayer()
        gl.frame = view.frame
        gl.colors = [color_left, color_right]
        gl.startPoint = CGPoint(x: 0.0, y: 0.5)
        gl.endPoint = CGPoint(x: 1.0, y: 0.5)
        view.layer.insertSublayer(gl, at: 0)
        image_view.addSubview(view)
        image_view.bringSubviewToFront(view)
        // set only bottom two corners
        let mask_path = UIBezierPath(roundedRect: self.bounds,
                                    byRoundingCorners: [.bottomLeft, .bottomRight],
                                    cornerRadii: CGSize(width: 20.0, height: 20.0))
        
        let shape = CAShapeLayer()
        shape.path = mask_path.cgPath
        self.layer.mask = shape
        self.layer.masksToBounds = true
        //more info button rounded corners
        self.more_info_button.layer.cornerRadius = 20.0
        self.more_info_button.layer.masksToBounds = true
        // Initialization code
    }
    
    /*
 var event_creator_id: String
 var event_title: String
 var event_summary: String
 var geo_radius: Int
 var lat: Double
 var long: Double
 var date_created: NSDate
 var comments_enabled: Bool
 var post_id_list: [PostObject]*/
    
    public func configure(with model: EventObject) {
        //imageView.image = model.image
        summary_description.text = model.event_summary
        event_name.text = model.event_title
        id.text = model.event_creator_id
    }
    
}
