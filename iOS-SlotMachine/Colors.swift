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
    var woodBG: CAGradientLayer!
    var whiteyBG: CAGradientLayer!
    var redBG: CAGradientLayer!
    var whiteBG: CAGradientLayer!
    
    
    let colorTop = UIColor.black.cgColor//UIColor(red: 192.0 / 255.0, green: 38.0 / 255.0, blue: 42.0 / 255.0, alpha: 1.0).cgColor
    let colorBottom = UIColor.darkGray.cgColor//UIColor(red: 35.0 / 255.0, green: 2.0 / 255.0, blue: 2.0 / 255.0, alpha: 1.0).cgColor

    let darkWood = UIColor(red: 152 / 255.0, green: 57 / 255.0, blue: 34 / 255.0, alpha: 1.0).cgColor
    let wood = UIColor(red: 194 / 255.0, green: 102 / 255.0, blue: 34 / 255.0, alpha: 1.0).cgColor
    let lightWood = UIColor(red: 237 / 255.0, green: 102 / 255.0, blue: 0 / 255.0, alpha: 1.0).cgColor
    let gold = UIColor(red: 237 / 255.0, green: 176 / 255.0, blue: 0 / 255.0, alpha: 1.0).cgColor
    let gray = UIColor.gray.cgColor
    
    let pickersLocation: [NSNumber]? = [ 0.0, 0.1, 0.5, 1.0 ]
    // rgb(255,215,0)
    init() {
        self.pickerBG = CAGradientLayer()
        self.pickerBG.colors = [ UIColor.gray, UIColor.white, UIColor.white, UIColor.gray ]
        self.pickerBG.locations = [ 0.0, 0.3, 0.7, 1.0]
        
        self.woodBG = CAGradientLayer()
        self.woodBG.colors = [ self.darkWood, self.wood, self.wood, self.darkWood]
        self.woodBG.locations = [0.0, 0.3, 0.7, 1.0 ]
        
        self.redBG = CAGradientLayer()
        self.redBG.colors = [ UIColor.red.cgColor, UIColor.white.cgColor, UIColor.white.cgColor, UIColor.red.cgColor]
        self.redBG.locations = self.pickersLocation
        
        self.whiteyBG = CAGradientLayer()
        self.whiteyBG.colors = [ UIColor.lightGray.cgColor, UIColor.white.cgColor, UIColor.white.cgColor, UIColor.lightGray.cgColor]
        self.whiteyBG.locations = self.pickersLocation
        
        self.whiteBG = CAGradientLayer()
        self.whiteBG.colors = [ UIColor.white.cgColor, UIColor.white.cgColor]
        self.whiteBG.locations = [ 0.0, 1.0]
        
        self.gl = CAGradientLayer()
        self.gl.colors = [colorTop, colorBottom, colorTop]
        self.gl.locations = [0.0, 0.7, 1.0]
    }
}
