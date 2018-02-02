//https://www.andrewcbancroft.com/2014/07/27/fade-in-out-animations-as-class-extensions-with-swift/#fade-without-extension

import Foundation
import UIKit

extension UILabel {
    func fadeIn() {
        // Move our fade out code from earlier
        UIView.animate(withDuration: ViewController.ANIMATION_COUNTING_INTERVAL, delay: ViewController.ANIMATION_DELAY, options: UIViewAnimationOptions.curveEaseIn, animations: {
            self.alpha = 1.0 // Instead of a specific instance of, say, birdTypeLabel, we simply set [thisInstance] (ie, self)'s alpha
        }, completion: fadeOut)
    }
    
    func fadeOut(_ finished: Bool = true) {
        if (!finished) {
            return
        }
        UIView.animate(withDuration: ViewController.ANIMATION_INTERVAL, delay: 0.0, options: UIViewAnimationOptions.curveEaseOut, animations: {
            self.alpha = 0.0
        }, completion: nil)
    }
}
