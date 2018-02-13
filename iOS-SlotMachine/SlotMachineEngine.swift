import Foundation
import SpriteKit
import UIKit

class SlotMachineEngine {
    
    var fruitsCount: Int
    var fliesCount: Int
    var selected1: Int
    var selected2: Int
    var selected3: Int
    var selected4: Int
    var selected5: Int
    var emptyRow: Int
    
    var jackpot: Int
    var money: Int
    var bet: Int
    var bonus: Int
    
    var disableFive: Bool
    var disableFifty: Bool
    var nullBet: Bool
    var isJackpot: Bool
    var fly: Bool
    
    var sounds: Sound = Sound()
    var random: Random = Random()
    
    init(FruitsCount fruitsCount: Int, FliesCount fliesCount: Int = 3) {
        self.fruitsCount = fruitsCount
        self.fliesCount = fliesCount
        self.emptyRow = self.fruitsCount
/**/
        // start with 5 "blanks"
        self.selected1 = self.emptyRow
        self.selected2 = self.emptyRow
        self.selected3 = self.emptyRow
        self.selected4 = self.emptyRow
        self.selected5 = self.emptyRow
/**/
        self.jackpot = 0
        self.money = 0
        self.bet = 0
        self.bonus = 0
        
        self.disableFive = true
        self.disableFifty = true
        self.nullBet = true
        self.isJackpot = false
        self.fly = false
        
        sounds.Start()
    }
    

    
    public func spin() {
        spinReels()
    }
    
    public func reset() {
        //call init?
        
    }

    public func insert(Value value: Int) {
        self.money += value
        
        if (self.money >= 5) {
            self.disableFive = false
        }
        
        if (self.money >= 50) {
            self.disableFifty = false
        }
    }
    
    public func resetBonus() {
        self.bonus = 0
    }
    
    public func resetJackpot() {
        self.jackpot = 0
        self.isJackpot = false
    }
    
    public func resetFly() {
        self.fly = false
    }
    
    public func bet(Value value: Int) -> Bool {
        // Only bet what you have
        if (value > self.money) {
            return false
        }
        
        self.bet += value
        self.jackpot += value   // sum all bets for jackpot prize
        self.money -= value
        
        if (self.money < 5) {
            self.disableFive = true
        }
        if (self.money < 50) {
            self.disableFifty = true
        }
        
        self.nullBet = false
        return true
    }
    
    private func spinReels() {
        
        //Spin Sound
        //spinPlayer.play()

        self.selected1 = rand()
        self.selected2 = rand()
        self.selected3 = rand()
        self.selected4 = rand()
        self.selected5 = rand()
        
        //let's reduce var names to simplify the code :-)
        let s1 = self.selected1
        let s2 = self.selected2
        let s3 = self.selected3
        let s4 = self.selected4
        let s5 = self.selected5
        
        /**** RULES *****************************************
         * 1. A fly in any position, no bonus (fly = index 0)
         * 2. 3 equals with 2 gaps, receive 1x bet back
         * 3. 3 equals with 1 gap, receive 2x bet back
         * 4. 3 equals in a row, receive 3x bet back
         * 5. 5 equals in a row, receive jackpot back
         ****************************************************/

        bonus = 0

        // check for flies (first rows)
        if (s1 >= fliesCount &&
            s2 >= fliesCount &&
            s3 >= fliesCount &&
            s4 >= fliesCount &&
            s5 >= fliesCount) {
            
            if (s1 == s2 && s2 == s3 && s3 == s4 && s4 == s5) {
              
                self.money += self.jackpot     // ***** JACKPOT WINNER *****
                bonus = self.jackpot
                self.isJackpot = true
            } else {
                
                checkForRepeatedFruits()

                if (bonus > 0) {
                    self.money += bonus
                    //sounds.shortPayOutPlayer.play()
                }else{
                    //sounds.lostPlayer.play()
                }
            
                self.bet = 0
                self.nullBet = true
                
            } // if (s1 == s2  && s2 == s3 && s3 == s4 && s4 == s5)
            
        } else {
            // Fly came
            self.bet = 0
            self.nullBet = true
            self.fly = true
            
        } // if (s1 > 0 && s2 > 0 && s3 > 0 && s4 > 0 && s5 > 0)

        print("Bonus = ", bonus)  // write bonus in the log
    }
    
    private func checkForRepeatedFruits() {
        // compares selected1 (s1) value with the second, third, forth and fifth reels
        let pivot1 = checkMatch(self.selected1)
        pivotCompare(pivot1)
        
        // compares selected2 (s2) value with the first, third, forth and fifth reels
        let pivot2 = checkMatch(self.selected2)
        pivotCompare(pivot2)
        
        // compares selected3 (s3) value with the first, second, forth and fifth reels
        let pivot3 = checkMatch(self.selected3)
        pivotCompare(pivot3)
    }
    
    private func pivotCompare(_ pivot: String) {
        if ( pivot == "TTTFF" || pivot == "FTTTF" || pivot == "FFTTT" ) {
            bonus = self.bet * 3
        } else if ( pivot == "TFTTF" || pivot == "FTTFT" || pivot == "TTFTF" || pivot == "TFTFT" || pivot == "FTFTT" ) {
            bonus = self.bet * 2
        } else if ( pivot == "TFFTT" || pivot == "TTFFT" ) {
            bonus = self.bet * 1
        }
    }
    
    private func rand() -> Int {
        return self.weightedRandom()
    }
    
    private func uniformRand() -> Int {
        return Int(arc4random_uniform(UInt32(self.fruitsCount)))
    }
    
    private func weightedRandom() -> Int {
        return random.weightedRandom()
    }
    
    private func setAllTo( _ row: Int) {
        self.selected1 = row
        self.selected2 = row
        self.selected3 = row
        self.selected4 = row
        self.selected5 = row
    }
    
    private func checkMatch( _ x: Int) -> String {
        var y = ""
        if self.selected1 == x { y = y + "T" } else { y = y + "F"}
        if self.selected2 == x { y = y + "T" } else { y = y + "F"}
        if self.selected3 == x { y = y + "T" } else { y = y + "F"}
        if self.selected4 == x { y = y + "T" } else { y = y + "F"}
        if self.selected5 == x { y = y + "T" } else { y = y + "F"}
        //play fly - lost everything
        //flyPlayer.play()
        return y
        
    }
}

