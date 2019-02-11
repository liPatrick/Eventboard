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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imageView.contentMode = UIView.ContentMode.scaleToFill
        self.layer.cornerRadius = 12.0
        self.layer.masksToBounds = true
        // Initialization code
    }
    
    public func configure(with model: CardModel) {
        imageView.image = model.image
        summaryDescription.text = model.summaryDescription
    }
    
}
