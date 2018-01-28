//
//  ViewController.swift
//  iOS-SlotMachine
//
//  Created by Student on 2018-01-23.
//  Copyright © 2018 Rafael Matos. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate{

    let colors = Colors()
    
    let EVEN = 0
    let ODD = 1
    
    let fruitsName = [
        "Apple",
        "Banana",
        "Cherry",
        "Grape",
        "Kiwi",
        "Lemon",
        "Mango",
        "Mangosteen",
        "Orange",
        "Pear",
        "Strawberry",
        "Watermelon"
    ]
    
    let fruits: [UIImage] = [
        #imageLiteral(resourceName: "Apple"), // blank row
        #imageLiteral(resourceName: "Apple"),
        #imageLiteral(resourceName: "Banana"),
        #imageLiteral(resourceName: "Cherry"),
        #imageLiteral(resourceName: "Grape"),
        #imageLiteral(resourceName: "Kiwi"),
        #imageLiteral(resourceName: "Lemon"),
        #imageLiteral(resourceName: "Mango"),
        #imageLiteral(resourceName: "Mangosteen"),
        #imageLiteral(resourceName: "Orange"),
        #imageLiteral(resourceName: "Pear"),
        #imageLiteral(resourceName: "Strawberry"),
        #imageLiteral(resourceName: "Watermelon")
    ]
    
    @IBOutlet weak var picker1: UIPickerView!
    
    @IBOutlet weak var picker2: UIPickerView!
    
    @IBOutlet weak var picker3: UIPickerView!
    
    @IBOutlet weak var picker4: UIPickerView!
    
    @IBOutlet weak var picker5: UIPickerView!
    
    @IBOutlet weak var spinButton: UIButton!
    @IBOutlet weak var fiveButton: UIButton!
    @IBOutlet weak var fiftyButton: UIButton!
    
    
    @IBOutlet weak var moneyTable: UIView!
    
    @IBOutlet weak var betTable: UIView!
    
    @IBOutlet weak var moneyLabel: UILabel!
    
    @IBOutlet weak var moneyValue: UILabel!
    
    @IBOutlet weak var jackpotHeader: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        draw()
    }
    
    private func draw() {
        
        buttonLayout(spinButton)
        //spinButton.backgroundColor = colors.watermelonRed
        
        //buttonLayout(fiveButton, false)
        //buttonLayout(fiftyButton, false)
        
        //betTable.layer.borderColor = colors.yellow
        //setGradientBackground(betTable, colors.redBG)
        
        //to change background, change woodBG to another color with BG on it
        //setGradientBackground(view, colors.whiteyBG)

        //setGradientBackground(betLabel, colors.whiteyBG)
        
        moneyTable.layer.borderColor = colors.watermelonDarkGreen.cgColor
        moneyTable.layer.borderWidth = 2
        moneyTable.layer.cornerRadius = 20
        
        betTable.layer.borderColor = colors.watermelonDarkGreen.cgColor
        betTable.layer.borderWidth = 2
        betTable.layer.cornerRadius = 20
        
        
        jackpotHeader.layer.cornerRadius = jackpotHeader.bounds.height / 2
        setAllPickersColor()
    }
    
    private func buttonLayout(_ button: UIButton!, _ hasBorder: Bool = true) {
        button.layer.borderColor = colors.watermelonDarkGreen.cgColor
        button.layer.borderWidth = 6
        button.layer.cornerRadius = button.frame.width / 2
    }
    
    private func setGradientBackground(_ view: UIView!,  _ color: CAGradientLayer!) {
        //view.backgroundColor = UIColor.clear
        
        let backgroundLayer: CAGradientLayer = color
        
        backgroundLayer.frame = view.bounds
        view.layer.insertSublayer(backgroundLayer, at: 0)
    }
    
    // PICKERVIEW DRAWING
    
    private func setAllPickersColor() {
        //picker1.backgroundColor = UIColor.clear
        setPickerColor(Picker: picker1)
        setPickerColor(Picker: picker2)
        setPickerColor(Picker: picker3)
        setPickerColor(Picker: picker4)
        setPickerColor(Picker: picker5)
    }
    
    private func setPickerColor(Picker picker: UIPickerView) {
        picker.backgroundColor = colors.watermelonLightGreen
        //let backgroundLayer = colors.pickerBG
        //picker.layer.insertSublayer(backgroundLayer!, at: 0)
        picker.layer.borderWidth = 6
        picker.layer.cornerRadius = 20
        picker.layer.borderColor = colors.watermelonDarkGreen.cgColor
    }

    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    /*
    @available(iOS 2.0, *)
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1;
    }
    */
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return fruits.count
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return #imageLiteral(resourceName: "Apple").size.height + 10 // + 10 is padding
    }
    
    
    // MARK: UIPickerViewDelegate
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        
        let myView = UIView(frame: CGRect(x:0, y:0, width: pickerView.bounds.width - 30, height:fruits[row].size.height))
        //let myView = UIView(frame: CGRect(x:0, y:0, width:pickerView.bounds.width - 30, height:60))
        
        // blank row
        if (row == 0) {
            return myView
        }
        
        let myImageView = UIImageView(frame: CGRect(x:0, y:0, width: fruits[row].size.width, height: fruits[row].size.height))
        //let myImageView = UIImageView(frame: CGRect(x:0, y:0, width: 50, height: 50))
        
        //var rowString = String()
        /*
        
        switch row % 2 {
        case EVEN:
            myView.backgroundColor = UIColor.white
        case ODD:
            myView.backgroundColor = UIColor.lightGray
        default:
            break
        }
        */

        // white background for each row
        //myView.backgroundColor = UIColor.white
        
        myImageView.image = fruits[row]
        
        /*
        rowString = fruitsName[row]
        let myLabel = UILabel(frame: CGRect(x:60, y:0, width:pickerView.bounds.width - 90, height:60 ))
        myLabel.font = UIFont(name: "Times New Roman", size: 18)
        myLabel.text = rowString
        myLabel.textColor = UIColor.white
        myView.addSubview(myLabel)
        */
        
        myView.addSubview(myImageView)
        
        return myView
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        // do something with selected row
    }

    
}

