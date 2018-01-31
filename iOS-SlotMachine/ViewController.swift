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
    
    let fruits: [UIImage] = [
        #imageLiteral(resourceName: "fly-1"),
        #imageLiteral(resourceName: "fly-2"),
        #imageLiteral(resourceName: "fly-3"),
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
    var game: SlotMachineEngine
    
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
    
    @IBOutlet weak var money: UILabel!
    @IBOutlet weak var bet: UILabel!
    @IBOutlet weak var jackpot: UILabel!
    
    @IBOutlet weak var jackpotHeader: UIView!
    
    required init?(coder aDecoder: NSCoder) {
        self.game = SlotMachineEngine(FruitsCount: fruits.count)
        super.init(coder: aDecoder)
        
        //fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        draw()
        
        self.drawReels()
        self.drawValues()
    }
    
    private func draw() {
        
        spinButton.layer.borderColor = colors.watermelonDarkGreen.cgColor
        spinButton.layer.borderWidth = 6
        spinButton.layer.cornerRadius = spinButton.frame.width / 2
        
        moneyTable.layer.borderColor = colors.watermelonDarkGreen.cgColor
        moneyTable.layer.borderWidth = 2
        moneyTable.layer.cornerRadius = 20
        
        betTable.layer.borderColor = colors.watermelonDarkGreen.cgColor
        betTable.layer.borderWidth = 2
        betTable.layer.cornerRadius = 20
        
        jackpotHeader.layer.cornerRadius = jackpotHeader.bounds.height / 2
        setAllPickersColor()
    }
    
    // PICKERVIEW DRAWING
    
    private func setAllPickersColor() {
        setPickerColor(Picker: picker1)
        setPickerColor(Picker: picker2)
        setPickerColor(Picker: picker3)
        setPickerColor(Picker: picker4)
        setPickerColor(Picker: picker5)
    }
    
    private func setPickerColor(Picker picker: UIPickerView) {
        picker.backgroundColor = colors.watermelonLightGreen
        picker.layer.borderWidth = 6
        picker.layer.cornerRadius = 20
        picker.layer.borderColor = colors.watermelonDarkGreen.cgColor
    }

    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return fruits.count + 1
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return #imageLiteral(resourceName: "Apple").size.height + 10 // + 10 is padding
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        
        let width: Int = Int(pickerView.bounds.width) - 30
        let height = 120
        
        //let myView = UIView(frame: CGRect(x:0, y:0, width: pickerView.bounds.width - 30, height:fruits[row].size.height))
        let myView = UIView(frame: CGRect(x:0, y:0, width: width, height:height))
        
        //blank row
        if (row == fruits.count) {
            return myView
        }
        
        //let myImageView = UIImageView(frame: CGRect(x:0, y:0, width: fruits[row].size.width, height: fruits[row].size.height))
        let myImageView = UIImageView(frame: CGRect(x:0, y:0, width: width, height: height))
        myImageView.image = fruits[row]
        myView.addSubview(myImageView)
        
        return myView
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        // do something with selected row
    }
    
    private func drawReels() {
        picker1.selectRow(game.selected1, inComponent: 0, animated: true)
        picker2.selectRow(game.selected2, inComponent: 0, animated: true)
        picker3.selectRow(game.selected3, inComponent: 0, animated: true)
        picker4.selectRow(game.selected4, inComponent: 0, animated: true)
        picker5.selectRow(game.selected5, inComponent: 0, animated: true)
    }
    
    private func drawValues() {
        self.money.text   = "$" + String(game.money)
        self.bet.text     = "$" + String(game.bet)
        self.jackpot.text = "$" + String(game.jackpot)
        
    }

    @IBAction func insertFive(_ sender: UIButton) {
        game.insert(Value:5)
        self.drawValues()
    }
    
    @IBAction func insertFifty(_ sender: UIButton) {
        game.insert(Value:50)
        self.drawValues()
    }
    
    @IBAction func betFive(_ sender: UIButton) {
        if (!game.bet(Value:5)) {
            print("Not enough Money to bet 5")
        }
        self.drawValues()
    }
    
    @IBAction func betFifty(_ sender: UIButton) {
        if (!game.bet(Value:50)) {
            print("Not enough Money to bet 50")
        }
        self.drawValues()
    }
    
    
    
    @IBAction func spin(_ sender: UIButton) {

        sender.pulsate()
        
        game.spin()
        drawReels()
    }
}

