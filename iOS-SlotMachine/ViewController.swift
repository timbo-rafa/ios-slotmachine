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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        refresh()
    }
    
    func refresh() {
        
        
        view.backgroundColor = UIColor.clear
        
        //to change background, assign backgroundLayer one of the BG variables from colors
        let backgroundLayer = colors.woodBG
        backgroundLayer?.frame = view.frame
        view.layer.insertSublayer(backgroundLayer!, at: 0)
        
        setAllPickersColor()
    }
    
    func setAllPickersColor() {
        //picker1.backgroundColor = UIColor.clear
        setPickerColor(Picker: picker1)
        setPickerColor(Picker: picker2)
        setPickerColor(Picker: picker3)
        setPickerColor(Picker: picker4)
        setPickerColor(Picker: picker5)
    }
    
    private func setPickerColor(Picker picker: UIPickerView) {
        picker.backgroundColor = UIColor.white
        //let backgroundLayer = colors.pickerBG
        //picker.layer.insertSublayer(backgroundLayer!, at: 0)
        picker.layer.borderWidth = 4
        picker.layer.cornerRadius = 20
        picker.layer.borderColor = colors.gray
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
        return #imageLiteral(resourceName: "Apple").size.height + 10
    }
    
    
    // MARK: UIPickerViewDelegate
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        
        let myView = UIView(frame: CGRect(x:0, y:0, width: pickerView.bounds.width - 30, height:fruits[row].size.height))
        //let myView = UIView(frame: CGRect(x:0, y:0, width:pickerView.bounds.width - 30, height:60))
        
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

        // white background for each picker
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

