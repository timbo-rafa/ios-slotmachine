import Foundation

import UIKit

extension UIButton {
    func pulsate() {
        
        
        let press = CASpringAnimation(keyPath: "transform.scale")
        press.duration = 0.6
        press.fromValue = 0.95
        press.toValue = 1.0
        press.autoreverses = true
        press.repeatCount = 1
        press.initialVelocity = 0.5
        press.damping = 1.0
        
        layer.add(press, forKey: nil)
    }
    
    func buttonize(_ borderWidth: CGFloat = 6, _ cornerRadius: CGFloat) {
        self.layer.borderColor = Colors.watermelonDarkGreen.cgColor
        self.layer.borderWidth = borderWidth
        self.layer.cornerRadius = cornerRadius
    }
}
