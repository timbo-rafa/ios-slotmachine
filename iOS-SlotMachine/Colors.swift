//
//  Colors.swift
//  iOS-SlotMachine
//
//  Created by Student on 2018-01-23.
//  Copyright © 2018 Rafael Matos. All rights reserved.
//

import UIKit

class Colors {
    var gl:CAGradientLayer!
    
    var pickerBG: CAGradientLayer!
    
    let colorTop = UIColor.black.cgColor//UIColor(red: 192.0 / 255.0, green: 38.0 / 255.0, blue: 42.0 / 255.0, alpha: 1.0).cgColor
    let colorBottom = UIColor.darkGray.cgColor//UIColor(red: 35.0 / 255.0, green: 2.0 / 255.0, blue: 2.0 / 255.0, alpha: 1.0).cgColor

    init() {
        self.pickerBG = CAGradientLayer()
        self.pickerBG.colors = [ UIColor.gray, UIColor.white, UIColor.white, UIColor.gray ]
        self.pickerBG.locations = [ 0.0, 0.3, 0.7, 1.0]
        
        self.gl = CAGradientLayer()
        self.gl.colors = [colorTop, colorBottom, colorTop]
        self.gl.locations = [0.0, 0.7, 1.0]
    }
}
