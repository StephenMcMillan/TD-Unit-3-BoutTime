//
//  ChronoGameManager.swift
//  Bout Time
//
//  Created by Stephen McMillan on 31/12/2018.
//  Copyright © 2018 Stephen McMillan. All rights reserved.
//

import Foundation
/*
    Steps to start:
    1) Populate 6 rounds of data with 4 events T=24

    Manager will handle the current round, score etc.

    View Controller will create the manager object.
    Set-up labels based on the array 'currentRound' in the manager object.

    When the user presses the buttons we can call a shift function which will mutate the 'currentRound' object
    Then we update the labels in the view controller
        REPEAT UNTIL:
        - Time lapses or,
        - User shakes device

    When one of these things happens:
     - The manager will need to check the order of the currentRound array which is an array of Events. It can do this by checking the date Int.
     - Each successive item should be greater than the previous.
     - How does the manager inform the view controller of the correct order etc / what is right and what is wrong (kinda relying on both objects being in sync a bit
*/

enum Direction {
    case up, down
}

enum EventPosition: Int{
    case first = 0
    case second, third, fourth
}

protocol ChronoGameManager {
    var score: Int { get set }
    var currentRound: Int { get set }
    var maxRounds: Int { get }
    
    var eventsInPlay: [Event] { get }
    var rounds: [[Event]] { get }
    
    /// Sets up the eventsInPlay object for then next round. Returns false if the game has reached the max number of rounds.
    func nextRound() -> Bool
    
    /// Shifts the event up or down in the array
    func shiftEvent(atPosition position: EventPosition, inDirection direction: Direction)
    func checkOrder() -> Bool
}

// A Chronological Ordering game for Aviation Events in History
class AviationChronoGame: ChronoGameManager {
    
    var score: Int = 0
    var currentRound: Int = 0
    var maxRounds: Int
    
    var eventsInPlay: [Event]
    var rounds: [[Event]]
    
    init?(numberOfRounds: Int) {
        // Ask question provider for x rounds
        
        do  {
            self.rounds = try FlightEventProvider.generateRounds(maxRounds: numberOfRounds)
            self.maxRounds = numberOfRounds
            self.eventsInPlay = rounds[currentRound]
        } catch {
            return nil
        }
    }
    
    func nextRound() -> Bool {
        currentRound += 1
    
        guard currentRound < maxRounds else { return false }
        
        eventsInPlay = rounds[currentRound]
        return true
    }
    
    func shiftEvent(atPosition position: EventPosition, inDirection direction: Direction) {
        
        // Using the 'swapAt' method to swap to items in the array. Essentially the caller provides the index of the item and a direction they wish to move it in the array. If they specify 'up' the item should move closer to the beginning of the array, otherwise it should move furthet to the end.
        switch direction {
            case .up: eventsInPlay.swapAt(position.rawValue, position.rawValue - 1)
            case .down: eventsInPlay.swapAt(position.rawValue, position.rawValue + 1)
        }
    }
    
    // Checks the order of the current array based on the dates of each event. Will return false if incorrect.
    func checkOrder() -> Bool {
        
        // Checking the dates in order from most historic to most recent...
        if eventsInPlay[0].year <= eventsInPlay[1].year &&
           eventsInPlay[1].year <= eventsInPlay[2].year &&
            eventsInPlay[2].year <= eventsInPlay[3].year {
            
            score += 1
            return true
        } else {
            return false
        }
    } 
}
