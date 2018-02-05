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
    var bonus: Int
    
    var disableFive: Bool
    var disableFifty: Bool
    var nullBet: Bool
    
    init(FruitsCount fruitsCount: Int) {
        self.fruitsCount = fruitsCount
        self.emptyRow = self.fruitsCount
/*
        // start with 5 "blanks"
        self.selected1 = self.emptyRow
        self.selected2 = self.emptyRow
        self.selected3 = self.emptyRow
        self.selected4 = self.emptyRow
        self.selected5 = self.emptyRow
*/
/**/
        // start with 5 "Spins" (Spin image must be in the UIImage declaration
        self.selected1 = 5
        self.selected2 = 5
        self.selected3 = 5
        self.selected4 = 5
        self.selected5 = 5
/**/
/*
        // start with 5 "Flys"
        self.selected1 = 0
        self.selected2 = 0
        self.selected3 = 0
        self.selected4 = 0
        self.selected5 = 0
*/
        
        self.jackpot = 0
        self.money = 0
        self.bet = 0
        self.bonus = 0
        
        self.disableFive = true
        self.disableFifty = true
        self.nullBet = true
    }
    
    public func spin() -> String {
        let bonus = spinReels()
        return "Bonus: $" + String(bonus)
    }
    
    public func reset() {
        
        print("Button reset clicked")
        /*
        self.jackpot = 0
        self.money = 0
        self.bet = 0
        self.bonus = 0
        
        self.selected1 = 5
        self.selected2 = 5
        self.selected3 = 5
        self.selected4 = 5
        self.selected5 = 5
        
        self.disableFive = true
        self.disableFifty = true
        self.nullBet = true
       */
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
    
    private func spinReels() -> Int {
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

//        if (s1 > 2 && s2 > 2 && s3 > 2 && s4 > 2 && s5 > 2) {
        if (s1 > 0 && s2 > 0 && s3 > 0 && s4 > 0 && s5 > 0) {
            
            if (s1 == s2 && s2 == s3 && s3 == s4 && s4 == s5) {
              
                self.money += self.jackpot     // ***** JACKPOT WINNER *****
                bonus = self.jackpot

            } else {
                
                let pivot1 = checkMatch(s1) // compares selected1 (s1) value with the second, third, forth and fifth reels
    
                if ( pivot1 == "TTTFF" || pivot1 == "FTTTF" || pivot1 == "FFTTT" ) {
                    bonus = self.bet * 3
                } else if ( pivot1 == "TFTTF" || pivot1 == "FTTFT" || pivot1 == "TTFTF" || pivot1 == "TFTFT" || pivot1 == "FTFTT" ) {
                    bonus = self.bet * 2
                } else if ( pivot1 == "TFFTT" || pivot1 == "TTFFT" ) {
                    bonus = self.bet * 1
                }

                let pivot2 = checkMatch(s2) // compares selected2 (s2) value with the first, third, forth and fifth reels
            
                if ( pivot2 == "TTTFF" || pivot2 == "FTTTF" || pivot2 == "FFTTT" ) {
                    bonus = self.bet * 3
                } else if ( pivot2 == "TFTTF" || pivot2 == "FTTFT" || pivot2 == "TTFTF" || pivot2 == "TFTFT" || pivot2 == "FTFTT" ) {
                    bonus = self.bet * 2
                } else if ( pivot2 == "TFFTT" || pivot2 == "TTFFT" ) {
                    bonus = self.bet * 1
                }

                let pivot3 = checkMatch(s3) // compares selected3 (s3) value with the first, second, forth and fifth reels
            
                if ( pivot3 == "TTTFF" || pivot3 == "FTTTF" || pivot3 == "FFTTT" ) {
                    bonus = self.bet * 3
                } else if ( pivot3 == "TFTTF" || pivot3 == "FTTFT" || pivot3 == "TTFTF" || pivot3 == "TFTFT" || pivot3 == "FTFTT" ) {
                    bonus = self.bet * 2
                } else if ( pivot3 == "TFFTT" || pivot3 == "TTFFT" ) {
                    bonus = self.bet * 1
                }

                if (bonus > 0) {
                    self.money += bonus
                }
            
                self.bet = 0
                self.nullBet = true
                
            } // if (s1 == s2  && s2 == s3 && s3 == s4 && s4 == s5)
            
        } else {
            
            self.bet = 0
            self.nullBet = true
            
        } // if (s1 > 0 && s2 > 0 && s3 > 0 && s4 > 0 && s5 > 0)

        print("Bonus = ", bonus)  // write bonus in the log
        return bonus
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
    
    private func checkMatch( _ x: Int) -> String {
        var y = ""
        if self.selected1 == x { y = y + "T" } else { y = y + "F"}
        if self.selected2 == x { y = y + "T" } else { y = y + "F"}
        if self.selected3 == x { y = y + "T" } else { y = y + "F"}
        if self.selected4 == x { y = y + "T" } else { y = y + "F"}
        if self.selected5 == x { y = y + "T" } else { y = y + "F"}
        return y
    }
}

