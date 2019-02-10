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
        let colorTop = UIColor(red: 247/255, green: 191/255, blue: 108/255, alpha: 1).cgColor
        let colorBottom = UIColor(red: 255/255, green: 169/255, blue: 58/255, alpha: 1).cgColor
        
        self.gl = CAGradientLayer()
        self.gl.colors = [colorTop, colorBottom]
        self.gl.locations = [0.0, 1.0]
    }
}

class ViewController: UIViewController {
    


    override func viewDidLoad() {
        super.viewDidLoad()
        
        let colors = Colors()

        view.backgroundColor = UIColor.clear
        var backgroundLayer = colors.gl
        backgroundLayer?.frame = view.frame
        view.layer.insertSublayer(backgroundLayer!, at: 0)

        
        //background color
       
        /*var gl: CAGradientLayer

        let colorTop = UIColor(red: 247/255, green: 191/255, blue: 108/255, alpha: 0.85)
        let colorBottom = UIColor(red: 245, green: 181, blue: 89, alpha: 1)
        
        gl = CAGradientLayer()
        gl.colors = [colorTop, colorBottom]
        gl.locations = [0.0, 1.0]
        
        view.backgroundColor = UIColor.clear
        let backgroundLayer = gl
        backgroundLayer.frame = view.frame
        view.layer.insertSublayer(backgroundLayer, at: 0)
*/
    }
}

