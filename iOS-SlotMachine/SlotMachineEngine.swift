import Foundation

class SlotMachineEngine {
    
    var fruitsCount: Int
    var selected1: Int
    var selected2: Int
    var selected3: Int
    var selected4: Int
    var selected5: Int
    var emptyRow: Int
    //var isBug: [Bool] = [false]
    
    init(FruitsCount fruitsCount: Int) {
        self.fruitsCount = fruitsCount
        self.emptyRow = self.fruitsCount
        
        self.selected1 = self.emptyRow
        self.selected2 = self.emptyRow
        self.selected3 = self.emptyRow
        self.selected4 = self.emptyRow
        self.selected5 = self.emptyRow
    }
    
    public func spin() {
        
        spinReels()
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
