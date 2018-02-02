import UIKit

extension UIPickerView {
    
    func paint() {
        self.backgroundColor = Colors.watermelonLightGreen
        self.layer.borderWidth = 6
        self.layer.cornerRadius = 20
        self.layer.borderColor = Colors.watermelonDarkGreen.cgColor
    }
    
    func flash(_ color: UIColor) {
        UIView.animate(withDuration: ViewController.ANIMATION_FLASH_INTERVAL, delay: ViewController.ANIMATION_DELAY, animations: {
            self.backgroundColor = color
        }, completion: flashFade)
        
    }
    
    private func flashFade(_ finished: Bool) {
        if (!finished) {
            return
        }
        UIView.animate(withDuration: ViewController.ANIMATION_INTERVAL, animations: {
            self.backgroundColor = Colors.watermelonLightGreen
        }, completion: nil)
    }
}
