//
//  ViewController.swift
//  Eventboard
//
//  Created by Patrick Li on 2/9/19.
//  Copyright © 2019 Patrick Li. All rights reserved.
//

import UIKit
import Foundation

class Colors {
    var gl:CAGradientLayer!
    
    init() {
        let colorTop = UIColor(red: 188/255, green: 156/255, blue: 255/255, alpha: 1).cgColor
        let colorBottom = UIColor(red: 139/255, green: 164/255, blue: 249/255, alpha: 1).cgColor
        
        self.gl = CAGradientLayer()
        self.gl.colors = [colorTop, colorBottom]
        self.gl.locations = [0.0, 1.0]
    }
}

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // setup colors
        
        let colors = Colors()

        view.backgroundColor = UIColor.clear
        var backgroundLayer = colors.gl
        backgroundLayer?.frame = view.frame
        view.layer.insertSublayer(backgroundLayer!, at: 0)
        
        // setup collection view
        self.collectionView.collectionViewLayout = CardsCollectionViewLayout()
        // change this later to a UIPageController to have the three white dots
        self.collectionView.isPagingEnabled = true
        self.collectionView.showsHorizontalScrollIndicator = false
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        
        // init custom cells
        self.collectionView.register(UINib.init(nibName: "CardView", bundle: nil), forCellWithReuseIdentifier: "CardCell")

    }
    
    let data : [CardModel] = [(CardModel(image: UIImage(named: "1024again")!, summaryDescription: "Hello, my name is Daniel Bessonov and I am a g.")),
                              (CardModel(image: UIImage(named: "boys")!, summaryDescription: "Hello, my name is Patrick Zhikuan Li and I am a bum."))]

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardCell", for: indexPath) as! CardViewCell
        //cell.backgroundColor = colors[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }

}

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        self.init(red: CGFloat(red)/255 ,
                  green: CGFloat(green)/255,
                  blue: CGFloat(blue)/255,
                  alpha: 1.0)
    }
}
