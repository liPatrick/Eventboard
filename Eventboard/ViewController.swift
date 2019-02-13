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

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var addEventButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // setup colors
        
        let colors = Colors()

        // set background color
        view.backgroundColor = UIColor.clear
        var backgroundLayer = colors.gl
        backgroundLayer?.frame = view.frame
        view.layer.insertSublayer(backgroundLayer!, at: 0)
        
        //setup circular button
        self.addEventButton.layer.cornerRadius = 0.5 * self.addEventButton.bounds.size.width
        self.addEventButton.clipsToBounds = true
        
        // setup collection view
        // change this later to a UIPageController to have the three white dots
        self.collectionView.isPagingEnabled = true
        self.collectionView.showsHorizontalScrollIndicator = false
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        
        // init custom cells
        self.collectionView.register(UINib.init(nibName: "CardView", bundle: nil), forCellWithReuseIdentifier: "CardCell")

    }
    
    // replace later with real data loaded from firebase
    let data : [CardModel] = [(CardModel(image: UIImage(named: "coffee")!, summaryDescription: "Presenting on the effects of early childhood dementia, utilizing blockchain technologies and neural networks.")),
                              (CardModel(image: UIImage(named: "coffee")!, summaryDescription: "Presenting on the effects of simple convoluntional neural networks, using MATLab and Python."))]

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardCell", for: indexPath) as! CardViewCell
        cell.configure(with: data[indexPath.row])
        //cell.backgroundColor = colors[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    // set min spacing between items
    func collectionView(_: UICollectionView, layout: UICollectionViewLayout, minimumLineSpacingForSectionAt: Int) -> CGFloat {
        // leave just enough of the card so that it shows up
        // fix later with real #s based on screen size
        return 70
    }
    
    // set default size
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // hardcoded for iphone xr
        return CGSize(width: 275, height: 375)
    }
    
    // set spacing on left
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        // center item in screen, and leave a tiny bit of space for next element
        let inset = UIEdgeInsets(top: 0, left: ((self.view.frame.width) / 2) - 162.5, bottom: 0, right: 70)
        // if single item, then center the element
        let insetSingleItem = UIEdgeInsets(top: 0, left: ((self.view.frame.width) / 2) - 137.5, bottom: 0, right: 70)
        
        // replace the hardcoded #s (162.5, 137.5) with screen.size.width stuff later
        // replace 70 with the size from minimumLineSpacing
        
        return (self.collectionView.numberOfItems(inSection: 0) > 1 ? inset : insetSingleItem)
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
