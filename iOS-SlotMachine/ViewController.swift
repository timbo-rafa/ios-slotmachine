//
//  ViewController.swift
//  iOS-SlotMachine
//
//  Created by Student on 2018-01-23.
//  Copyright © 2018 Rafael Matos. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate {
    let colors = Colors()
    
    @IBOutlet weak var picker1: UIPickerView!
    
    @IBOutlet weak var picker2: UIPickerView!
    
    @IBOutlet weak var picker3: UIPickerView!
    
    @IBOutlet weak var picker4: UIPickerView!
    
    @IBOutlet weak var picker5: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        refresh()
    }
    
    func refresh() {
        
        
        view.backgroundColor = UIColor.clear
        let backgroundLayer = colors.gl
        backgroundLayer?.frame = view.frame
        view.layer.insertSublayer(backgroundLayer!, at: 0)
        
        //setAllPickersColor()
    }
    
    func setAllPickersColor() {
        picker1.backgroundColor = UIColor.clear
        setPickerColor(Picker: picker1)
        setPickerColor(Picker: picker2)
        setPickerColor(Picker: picker3)
        setPickerColor(Picker: picker4)
        setPickerColor(Picker: picker5)
    }
    
    private func setPickerColor(Picker picker: UIPickerView) {
        picker.backgroundColor = UIColor.white
        let backgroundLayer = colors.pickerBG
        picker.layer.insertSublayer(backgroundLayer!, at: 0)
        picker.layer.borderWidth = 10
        picker.layer.cornerRadius = 5
        picker.layer.borderColor = UIColor.lightGray.cgColor
    }

    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 12
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 60
    }
    
    
    // MARK: UIPickerViewDelegate
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        
        let myView = UIView(frame: CGRect(x:0, y:0, width:pickerView.bounds.width - 30, height:60))
        
        let myImageView = UIImageView(frame: CGRect(x:0, y:0, width:50, height:50))
        
        var rowString = String()
        /*
         switch row {
         case 0:
         rowString = “Washington”
         myImageView.image = UIImage(named:"washington.jpg")
         case 1:
         rowString = “Beijing”
         myImageView.image = UIImage(named:"beijing.jpg")
         case 2:
         default:
         rowString = "Error: too many rows"
         myImageView.image = nil
         }
         */
        rowString = "Apple"
        myImageView.image = #imageLiteral(resourceName: "Apple")
        let myLabel = UILabel(frame: CGRect(x:60, y:0, width:pickerView.bounds.width - 90, height:60 ))
        myLabel.font = UIFont(name: "Times New Roman", size: 18)
        myLabel.text = rowString
        
        myView.addSubview(myLabel)
        myView.addSubview(myImageView)
        
        return myView
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        // do something with selected row
    }

    
}

