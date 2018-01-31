import Foundation

class SlotMachineEngine {
    
    var fruitsCount: Int
    var selected1: Int
    var selected2: Int
    var selected3: Int
    var selected4: Int
    var selected5: Int
    var emptyRow: Int
    
    var jackpot: Int
    var money: Int
    var bet: Int
    
    var disableFive: Bool
    var disableFifty: Bool
    var nullBet: Bool
    
    init(FruitsCount fruitsCount: Int) {
        self.fruitsCount = fruitsCount
        self.emptyRow = self.fruitsCount
        
        self.selected1 = self.emptyRow
        self.selected2 = self.emptyRow
        self.selected3 = self.emptyRow
        self.selected4 = self.emptyRow
        self.selected5 = self.emptyRow
        
        self.jackpot = 0
        self.money = 0
        self.bet = 0
        
        self.disableFive = true
        self.disableFifty = true
        self.nullBet = true
    }
    
    public func spin() {
        
        spinReels()
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
    
    public func bet(Value value: Int) -> Bool {
        // Only bet what you have
        if (value > self.money) {
            return false
        }
        
        self.bet += value
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
        self.selected1 = rand()
        self.selected2 = rand()
        self.selected3 = rand()
        self.selected4 = rand()
        self.selected5 = rand()
    }
    
    private func rand() -> Int {
        return Int(arc4random_uniform(UInt32(self.fruitsCount)))
    }
    
    private func setAllTo( _ row: Int) {
        self.selected1 = row
        self.selected2 = row
        self.selected3 = row
        self.selected4 = row
        self.selected5 = row
    }
}
