//
//  Random.swift
//  iOS-SlotMachine
//
//  Created by Student on 2018-02-05.
//  Copyright © 2018 Rafael Matos. All rights reserved.
//

import Foundation

class Random {
        
    // Probability of rolling each fly/fruit
    let P_FLY_1      = 1.0
    let P_FLY_2      = 1.0
    let P_FLY_3      = 1.0
    let P_APPLE      = 5.0
    let P_BANANA     = 7.0
    let P_CHERRY     = 3.0
    let P_GRAPE      = 4.0
    let P_KIWI       = 2.0
    let P_LEMON      = 5.0
    let P_MANGO      = 5.0
    let P_MANGOSTEEN = 4.0
    let P_ORANGE     = 5.0
    let P_PEAR       = 5.0
    let P_STRAWBERRY = 1.5
    let P_WATERMELON = 7.0
    
    public func weightedRandom() -> Int {
        return randomNumber(probabilities: [
          P_FLY_1,
          P_FLY_2,
          P_FLY_3,
          P_APPLE,
          P_BANANA,
          //P_CHERRY,
          P_GRAPE,
          //P_KIWI,
          P_LEMON,
          //P_MANGO,
          //P_MANGOSTEEN,
          P_ORANGE,
          //P_PEAR,
          P_STRAWBERRY,
          P_WATERMELON
        ])
    }
    
    private func randomNumber(probabilities: [Double]) -> Int {
        
        // Sum of all probabilities (so that we don't have to require that the sum is 1.0):
        let sum = probabilities.reduce(0, +)
        // Random number in the range 0.0 <= rnd < sum :
        let rnd = sum * Double(arc4random_uniform(UInt32.max)) / Double(UInt32.max)
        // Find the first interval of accumulated probabilities into which `rnd` falls:
        var accum = 0.0
        for (i, p) in probabilities.enumerated() {
            accum += p
            if rnd < accum {
                return i
            }
        }
        // This point might be reached due to floating point inaccuracies:
        return (probabilities.count - 1)
    }
}
