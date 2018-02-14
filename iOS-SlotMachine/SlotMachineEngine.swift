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
    var matchedFruit: Int
    
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
        self.matchedFruit = self.emptyRow
        
        self.disableFive = true
        self.disableFifty = true
        self.nullBet = true
        self.isJackpot = false
        self.fly = false
        
        sounds.Start()
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
    
    public func resetBet() {
        self.bet = 0
        self.nullBet = true
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
    
    public func spin() {
        spinReels()
        calculateBonus()
    }
    
    private func spinReels() {
        self.selected1 = rand()
        self.selected2 = rand()
        self.selected3 = rand()
        self.selected4 = rand()
        self.selected5 = rand()
    }
    
    private func calculateBonus() {
        self.resetBonus()
        self.resetFly()
        
        if (!self.fliesSelected()) {
            self.matchFruits()
            
            if (bonus > 0) {
                self.money += bonus
            }
        }
        self.resetBet()
        
        print("Bonus = ", bonus)  // write bonus in the log
    }
    
    private func fliesSelected() -> Bool {
        // check for flies (first rows)
        self.fly = false
        if (self.selected1 < self.fliesCount) { self.fly = true }
        if (self.selected2 < self.fliesCount) { self.fly = true }
        if (self.selected3 < self.fliesCount) { self.fly = true }
        if (self.selected4 < self.fliesCount) { self.fly = true }
        if (self.selected5 < self.fliesCount) { self.fly = true }
        return self.fly
    }
    
    private func matchFruits() {
        matchFruit(self.selected1)
        matchFruit(self.selected2)
        matchFruit(self.selected3)
        // since 3 or more fruits are needed,
        // we do not need to compare for
        // selected4 and selected5
    }
    
    private func matchFruit(_ fruit: Int) {
        let count = matches(fruit)
        awardRepeatedFruits(count)
        if (count > 2) {
            self.matchedFruit = fruit
        }
    }
    
    private func awardRepeatedFruits(_ count: Int) {
        if (count == 5) {
            self.money += self.jackpot
            bonus = self.jackpot
            self.isJackpot = true
        } else if (count == 4) {
            bonus = self.bet * 3
        } else if (count == 3) {
            bonus = self.bet * 2
        }
        //no award for 2 or 1 repeated fruits
    }
    
    private func matches(_ fruit: Int) -> Int {
        // returns how many fruits there are equal to the passed one.
        var count: Int = 0
        if (isSameFruit(self.selected1, fruit)) { count = count + 1 }
        if (isSameFruit(self.selected2, fruit)) { count = count + 1 }
        if (isSameFruit(self.selected3, fruit)) { count = count + 1 }
        if (isSameFruit(self.selected4, fruit)) { count = count + 1 }
        if (isSameFruit(self.selected5, fruit)) { count = count + 1 }
        return count
    }
    
    private func isSameFruit(_ fruit1: Int, _ fruit2: Int) -> Bool {
        if fruit1 == fruit2 { return true }
        else { return false }
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
}

