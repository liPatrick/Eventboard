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
        // Initialization code
    }
    
    public func configure(with model: CardModel) {
        image.image = model.image
        name.text = model.name
    }
    
}
