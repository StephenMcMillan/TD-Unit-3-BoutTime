//
//  Event.swift
//  Bout Time
//
//  Created by Stephen McMillan on 31/12/2018.
//  Copyright © 2018 Stephen McMillan. All rights reserved.
//

import Foundation

struct Event {
    let description: String
    let year: Int
}

enum EventProviderError: Error {
    case insufficientEvents
}

struct FlightEventProvider {
    static let majorFlightEvents: [Event] = [
    Event(description: "The first flight made by the Wright Brothers", year: 1903),
    Event(description: "The first untethered manned hot air balloon flight", year: 1783),
    Event(description: "Charles Lindbergh completes the first solo non-stop trans-Atlantic flight.", year: 1927),
    Event(description: "British inventor Frank Whittle invents the jet engine.", year: 1930),
    Event(description: "Amelia Earhart is the first woman to fly a solo non-stop trans-Atlantic flight.", year: 1932),
    Event(description: "Boeing 747 makes the first commercial flight.", year: 1970),
    Event(description: "Charles Yeager pilots the first aircraft to exceed the speed of sound in level flight.", year: 1947),
    Event(description: "Concorde begins its first passenger-carrying service.", year: 1976),
    Event(description: "World’s first flying car", year: 2011),
    Event(description: "Solar Impulse 2 is the first plane powered by a renewable energy source to tour the globe.", year: 2016),
    Event(description: "The first flight of the Spitfire.", year: 1936),
    Event(description: "First zeppelin flight.", year: 1900),
    Event(description: "First transatlantic hot-air balloon flight.", year: 1987),
    Event(description: "The Airbus A350 flies for the first time.", year: 2013),
    Event(description: "Delta Airlines begins operating in the US.", year: 1929),
    Event(description: "The Airbus A380 flies for the first time.", year: 2005),
    Event(description: "The Tenerife disaster, one of the biggest aviation accidents, occurs.", year: 1977),
    Event(description: "First all-female jet airliner cockpit and flight attendant crew.", year: 1986),
    Event(description: "First human steps foot on the moon.", year: 1969),
    Event(description: "The first Space Shuttle launches.", year: 1981),
    Event(description: "The Boeing 707 first took to the skies.", year: 1957),
    Event(description: "Boeing Commercial Airplanes is founded.", year: 1916),
    Event(description: "The Boeing 787 flies for the first time.", year: 2009),
    Event(description: "Italian artist and inventor Leonardo da Vinci made drawings of flying machines with flapping wings.", year: 1500),
    Event(description: "Sir George Cayley of Great Britain flew the first successful model glider.", year: 1804),
    Event(description: "Brooke Knapp, a U.S. pilot, flew around the world in a record time of 45 hours 32 minutes 53 seconds.", year: 1984)]
    
    static func generateRounds(maxRounds: Int) throws -> [[Event]] {

        // Check if the events array contains enough to fulfil the request, otherwise throw an error.
        guard majorFlightEvents.count >= maxRounds * 4 else {
            throw EventProviderError.insufficientEvents
        }
        
        var rounds: [[Event]] = []
        
        for _ in 0..<maxRounds {
            let thisRound = majorFlightEvents.shuffled().prefix(4)
            
            rounds.append(Array(thisRound))
        }
        
        return rounds
    }
}
