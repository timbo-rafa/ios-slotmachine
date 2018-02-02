//https://www.andrewcbancroft.com/2014/07/27/fade-in-out-animations-as-class-extensions-with-swift/#fade-without-extension

import Foundation
import UIKit

extension UILabel {
    
    func pop() {
        self.isHidden = false
        self.move()
        self.fadeIn()
    }
    
    func move() {
        UIView.animate(withDuration: ViewController.ANIMATION_INTERVAL + ViewController.ANIMATION_COUNTING_INTERVAL, delay: ViewController.ANIMATION_DELAY, animations: {
            self.frame = self.frameOffset(self.frame, ViewController.ANIMATION_OFFSET)
        }, completion: moveBack)
    }
    
    func moveBack(_ finished: Bool) {
        self.frame = self.frameOffset(self.frame, -ViewController.ANIMATION_OFFSET)
    }
    
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
        }, completion: hide)
    }
    
    func hide(_ finished: Bool) {
        self.isHidden = true
    }
 
    private func frameOffset(_ frame: CGRect, _ offset: CGFloat) -> CGRect {
        return CGRect(x: frame.origin.x, y: frame.origin.y - offset, width: frame.size.width, height: frame.size.height)
        
    }
}
