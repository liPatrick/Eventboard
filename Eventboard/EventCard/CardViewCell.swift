//
//  CardViewCell.swift
//  Eventboard
//
//  Created by Daniel Bessonov on 2/10/19.
//  Copyright © 2019 Patrick Li. All rights reserved.
//

import UIKit

class CardViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var summaryDescription: UILabel!
    @IBOutlet weak var summaryLabel: UILabel!
    @IBOutlet weak var moreInfoButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // scale image proportionally
        imageView.contentMode = UIView.ContentMode.scaleAspectFill
        // make sure image doesn't go over bounds
        imageView.layer.masksToBounds = true
        // hardcore image for now
        imageView.image = UIImage(named: "coffee")
        // add gradient to image
        let colorLeft = UIColor(red: 0.12, green: 0.13, blue: 0.25, alpha: 1).cgColor
        let colorRight = UIColor(red: 0.12, green: 0.13, blue: 0.25, alpha: 0.05).cgColor
        let view = UIView(frame: imageView.frame)
        let gl = CAGradientLayer()
        gl.frame = view.frame
        gl.colors = [colorLeft, colorRight]
        gl.startPoint = CGPoint(x: 0.0, y: 0.5)
        gl.endPoint = CGPoint(x: 1.0, y: 0.5)
        view.layer.insertSublayer(gl, at: 0)
        imageView.addSubview(view)
        imageView.bringSubviewToFront(view)
        // set only bottom two corners
        let maskPath = UIBezierPath(roundedRect: self.bounds,
                                    byRoundingCorners: [.bottomLeft, .bottomRight],
                                    cornerRadii: CGSize(width: 20.0, height: 20.0))
        
        let shape = CAShapeLayer()
        shape.path = maskPath.cgPath
        self.layer.mask = shape
        self.layer.masksToBounds = true
        //more info button rounded corners
        self.moreInfoButton.layer.cornerRadius = 20.0
        self.moreInfoButton.layer.masksToBounds = true
        // Initialization code
    }
    
    public func configure(with model: CardModel) {
        imageView.image = model.image
        summaryDescription.text = model.summaryDescription
    }
    
}
