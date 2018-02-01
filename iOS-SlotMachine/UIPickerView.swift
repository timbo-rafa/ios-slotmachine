//
//  UIPickerView.swift
//  iOS-SlotMachine
//
//  Created by Student on 2018-01-31.
//  Copyright © 2018 Rafael Matos. All rights reserved.
//

import Foundation
import UIKit

extension UIPickerView {
    
    func paint() {
        self.backgroundColor = Colors.watermelonLightGreen
        self.layer.borderWidth = 6
        self.layer.cornerRadius = 20
        self.layer.borderColor = Colors.watermelonDarkGreen.cgColor
    }
    
    func flash() {
        
    }
}
