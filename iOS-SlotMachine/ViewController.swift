//
//  ViewController.swift
//  iOS-SlotMachine
//
//  Created by Rafael Timbo 300962678,
//  Fernando Ito 300960367
//  and Sergio Brunacci 300910506
//  on 2018-02-04.
//  Copyright © 2018 Rafael Matos. All rights reserved.
//  App: Watermelon Jackpot 1.0
//  A Slot machine game with a kitchen theme that uses fruits as slot items, and flies as fail
//  To win you need to get 3 or more equal fruits and no flies.

import UIKit
import SpriteKit

class ViewController: UIViewController, UIPickerViewDelegate {

    static let ANIMATION_DELAY = 0.2
    static let ANIMATION_INTERVAL = 1.0
    static let ANIMATION_FLASH_INTERVAL = 0.2
    static let ANIMATION_COUNTING_INTERVAL = 1.0
    static let ANIMATION_OFFSET: CGFloat = 40
    
    
    // Original UIImage
    let fruits: [UIImage] = [
        #imageLiteral(resourceName: "fly-1"),
        #imageLiteral(resourceName: "fly-2"),
        #imageLiteral(resourceName: "fly-3"),
        #imageLiteral(resourceName: "Apple"),
        #imageLiteral(resourceName: "Banana"),
        //#imageLiteral(resourceName: "Cherry"),
        #imageLiteral(resourceName: "Grape"),
        //#imageLiteral(resourceName: "Kiwi"),
        #imageLiteral(resourceName: "Lemon"),
        //#imageLiteral(resourceName: "Mango"),
        //#imageLiteral(resourceName: "Mangosteen"),
        #imageLiteral(resourceName: "Orange"),
        //#imageLiteral(resourceName: "Pear"),
        #imageLiteral(resourceName: "Strawberry"),
        #imageLiteral(resourceName: "Watermelon")
    ]
    
    var game: SlotMachineEngine
    var sound: Sound = Sound()
    
    @IBOutlet weak var picker1: UIPickerView!
    
    @IBOutlet weak var picker2: UIPickerView!
    
    @IBOutlet weak var picker3: UIPickerView!
    
    @IBOutlet weak var picker4: UIPickerView!
    
    @IBOutlet weak var picker5: UIPickerView!
    
    @IBOutlet weak var quitButton: UIButton!
    @IBOutlet weak var resetButton: UIButton!
    @IBOutlet weak var spinButton: UIButton!
    @IBOutlet weak var fiveButton: UIButton!
    @IBOutlet weak var fiftyButton: UIButton!
    @IBOutlet weak var betFive: UIButton!
    @IBOutlet weak var betFifty: UIButton!
    
    @IBOutlet weak var moneyTable: UIView!
    
    @IBOutlet weak var betTable: UIView!
    
    @IBOutlet weak var moneyLabel: UILabel!
    
    //UI placeholders, reserve space on storyboard for actual variables below
    @IBOutlet weak var _money: UILabel!
    @IBOutlet weak var _bet: UILabel!
    @IBOutlet weak var _jackpot: UILabel!
    
    //Animated-counting labels
    var money: AnimatedLabel
    var bet: AnimatedLabel
    var jackpot: AnimatedLabel
    
    @IBOutlet weak var payout: UILabel!
    
    @IBOutlet weak var jackpotHeader: UIView!
    
    required init?(coder aDecoder: NSCoder) {
        self.game = SlotMachineEngine(FruitsCount: fruits.count)
        self.money = AnimatedLabel()
        self.bet = AnimatedLabel()
        self.jackpot = AnimatedLabel()
        
        sound.Start()
        
        super.init(coder: aDecoder)
        
        
        //fatalError("init(coder:) has not been implemented")
    }
    
    
    @IBAction func pressQuit(_ sender: UIButton) {
        //suspend the app in second plan
        //UIControl().sendAction(#selector(NSXPCConnection.suspend), to: UIApplication.shared, for: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.paint()

        self.setupAnimatedLabels()
        
        self.draw()
        
        
        
        
    }
    
    private func setupAnimatedLabels() {
        //substitute UILabels to AnimatedLabels
        
        money.copyLabel(Label:_money)
        _money.isHidden = true
        moneyTable.addSubview(money)
        
        bet.copyLabel(Label: _bet)
        _bet.isHidden = true
        betTable.addSubview(bet)
        
        jackpot.copyLabel(Label: _jackpot)
        _jackpot.isHidden = true
        jackpotHeader.addSubview(jackpot)
        
    }
    
    private func paint() {
        // stylize the game
        //spinButton.layer.borderColor = Colors.watermelonDarkGreen.cgColor
        //spinButton.layer.borderWidth = 6
        //spinButton.layer.cornerRadius = spinButton.frame.width / 2
        
        spinButton.buttonize(6, spinButton.frame.width / 2)
        quitButton.buttonize(3, quitButton.frame.height / 3)
        resetButton.buttonize(3, quitButton.frame.height / 3)
        
        moneyTable.layer.borderColor = Colors.watermelonDarkGreen.cgColor
        moneyTable.layer.borderWidth = 2
        moneyTable.layer.cornerRadius = 20
        
        betTable.layer.borderColor = Colors.watermelonDarkGreen.cgColor
        betTable.layer.borderWidth = 2
        betTable.layer.cornerRadius = 20
        
        //payout.isEnabled =
        
        jackpotHeader.layer.cornerRadius = jackpotHeader.bounds.height / 3
        setAllPickersColor()
        disablePickerUserInteraction()
    }
    

    
    private func disablePickerUserInteraction() {
        picker1.isUserInteractionEnabled = false
        picker2.isUserInteractionEnabled = false
        picker3.isUserInteractionEnabled = false
        picker4.isUserInteractionEnabled = false
        picker5.isUserInteractionEnabled = false
    }
    
    // PICKERVIEW DRAWING
    
    private func setAllPickersColor() {
        picker1.paint()
        picker2.paint()
        picker3.paint()
        picker4.paint()
        picker5.paint()
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return fruits.count + 1 // + 1 for starting empty row
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
        // return all pickers to last line so all reels rolls up on animation
        picker1.selectRow(game.emptyRow, inComponent: 0, animated: false)
        picker2.selectRow(game.emptyRow, inComponent: 0, animated: false)
        picker3.selectRow(game.emptyRow, inComponent: 0, animated: false)
        picker4.selectRow(game.emptyRow, inComponent: 0, animated: false)
        picker5.selectRow(game.emptyRow, inComponent: 0, animated: false)

        // display selected rows
        picker1.selectRow(game.selected1, inComponent: 0, animated: true)
        picker2.selectRow(game.selected2, inComponent: 0, animated: true)
        picker3.selectRow(game.selected3, inComponent: 0, animated: true)
        picker4.selectRow(game.selected4, inComponent: 0, animated: true)
        picker5.selectRow(game.selected5, inComponent: 0, animated: true)
//        picker1.flash(Colors.yellow)
//        picker5.flash(Colors.gray)
    }
    
    private func drawValues() {
        self.money.countFromCurrent(to: Float(game.money), duration: ViewController.ANIMATION_COUNTING_INTERVAL)
        self.bet.countFromCurrent(to: Float(game.bet), duration: ViewController.ANIMATION_COUNTING_INTERVAL)
        self.jackpot.countFromCurrent(to: Float(game.jackpot), duration: ViewController.ANIMATION_COUNTING_INTERVAL)
        
        if (game.bonus > 0) {
            sound.shortPayOutPlayer.play()
            payout.text = "$" + String( game.bonus)
            payout.pop()
        }else {
            //sound.lostPlayer.play()
            payout.text = "$0"
        }
        game.resetBonus()
        
        self.disableBetIfNeeded()
    }
    
    private func draw() {
        //update the UI on each game tick
        self.drawReels()
        self.drawValues()
    }
    
    private func disableBetIfNeeded() {
        betFive.isEnabled = !game.disableFive
        betFifty.isEnabled = !game.disableFifty
        spinButton.isEnabled = !game.nullBet
    }

    @IBAction func insertFive(_ sender: UIButton) {
        game.insert(Value:5)
        sound.coinPlayer.play()
        self.drawValues()
    }
    
    @IBAction func insertFifty(_ sender: UIButton) {
        game.insert(Value:50)
        sound.coinPlayer.play()
        self.drawValues()
    }
    
    @IBAction func betFive(_ sender: UIButton) {
        if (!game.bet(Value:5)) {
            print("Not enough Money to bet 5")
        }
        self.drawValues()
        sound.coinPlayer.play()
    }
    
    @IBAction func betFifty(_ sender: UIButton) {
        if (!game.bet(Value:50)) {
            print("Not enough Money to bet 50")
        }
        self.drawValues()
        sound.coinPlayer.play()
    }
    
    @IBAction func spin(_ sender: UIButton) {
        sender.pulsate()
        //spinPlayer.play()
        game.spin()

        self.draw()
        //spinPlayer.stop()
    }
    
    @IBAction func reset(_ sender: UIButton) {
        //game.reset()
        print("Reset")
        game = SlotMachineEngine(FruitsCount: fruits.count)
        self.draw()
    }
}

