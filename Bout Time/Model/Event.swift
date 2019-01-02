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
    let infoURL: String
}

enum EventProviderError: Error {
    case insufficientEvents
}

struct FlightEventProvider {
    static let majorFlightEvents: [Event] = [
        Event(description: "The first flight made by the Wright Brothers", year: 1903, infoURL: "https://en.wikipedia.org/wiki/Wright_brothers"),
    Event(description: "The first untethered manned hot air balloon flight", year: 1783, infoURL: "https://en.wikipedia.org/wiki/Hot_air_balloon"),
    Event(description: "Charles Lindbergh completes the first solo non-stop trans-Atlantic flight.", year: 1927, infoURL: "https://pioneersofflight.si.edu/content/first-solo-nonstop-transatlantic-flight"),
    Event(description: "British inventor Frank Whittle invents the jet engine.", year: 1930, infoURL: "https://en.wikipedia.org/wiki/Frank_Whittle"),
    Event(description: "Amelia Earhart is the first woman to fly a solo non-stop trans-Atlantic flight.", year: 1932, infoURL: "https://en.wikipedia.org/wiki/Amelia_Earhart"),
    Event(description: "Boeing 747 makes the first commercial flight.", year: 1970, infoURL: "https://en.wikipedia.org/wiki/Boeing_747"),
    Event(description: "Charles Yeager pilots the first aircraft to exceed the speed of sound in level flight.", year: 1947, infoURL: "https://en.wikipedia.org/wiki/Chuck_Yeager"),
    Event(description: "Concorde begins its first passenger-carrying service.", year: 1976, infoURL: "https://en.wikipedia.org/wiki/Concorde"),
    Event(description: "World’s first flying car", year: 2011, infoURL: "https://theguardian.com/technology/2011/jan/30/flying-car-terrafugia-transition-aircraft"),
    Event(description: "Solar Impulse 2 is the first plane powered by a renewable energy source to tour the globe.", year: 2016, infoURL: "https://en.wikipedia.org/wiki/Solar_Impulse"),
    Event(description: "The first flight of the Spitfire.", year: 1936, infoURL: "https://en.wikipedia.org/wiki/Supermarine_Spitfirev"),
    Event(description: "First zeppelin flight.", year: 1900, infoURL: "https://en.wikipedia.org/wiki/Zeppelin"),
    Event(description: "First transatlantic hot-air balloon flight.", year: 1987, infoURL: "https://guinnessworldrecords.com/news/60at60/2015/8/1987-first-people-to-cross-the-atlantic-in-a-hot-air-balloon-392904"),
    Event(description: "The Airbus A350 flies for the first time.", year: 2013, infoURL: "https://en.wikipedia.org/wiki/Airbus_A350"),
    Event(description: "Delta Airlines begins operating in the US.", year: 1929, infoURL: "https://en.wikipedia.org/wiki/Delta_Air_Lines"),
    Event(description: "The Airbus A380 flies for the first time.", year: 2005, infoURL: "https://en.wikipedia.org/wiki/Airbus_A380"),
    Event(description: "The Tenerife disaster, one of the biggest aviation accidents, occurs.", year: 1977, infoURL: "https://en.wikipedia.org/wiki/Tenerife_airport_disaster"),
    Event(description: "First all-female jet airliner cockpit and flight attendant crew.", year: 1986, infoURL: "https://en.wikipedia.org/wiki/Women_in_aviation"),
    Event(description: "First human steps foot on the moon.", year: 1969, infoURL: "https://en.wikipedia.org/wiki/Apollo_11"),
    Event(description: "The first Space Shuttle launches.", year: 1981, infoURL: "https://en.wikipedia.org/wiki/Space_Shuttle"),
    Event(description: "The Boeing 707 first took to the skies.", year: 1957, infoURL: "https://en.wikipedia.org/wiki/Boeing_707"),
    Event(description: "Boeing Commercial Airplanes is founded.", year: 1916, infoURL: "https://en.wikipedia.org/wiki/Boeing_Commercial_Airplanes"),
    Event(description: "The Boeing 787 flies for the first time.", year: 2009, infoURL: "https://en.wikipedia.org/wiki/Boeing_787_Dreamliner"),
    Event(description: "Italian artist and inventor Leonardo da Vinci made drawings of flying machines with flapping wings.", year: 1500, infoURL: "https://da-vinci-inventions.com/flying-machine.aspx"),
    Event(description: "Sir George Cayley of Great Britain flew the first successful model glider.", year: 1804, infoURL: "https://en.wikipedia.org/wiki/George_Cayley"),
    Event(description: "Brooke Knapp, a U.S. pilot, flew around the world in a record time of 45 hours 32 minutes 53 seconds.", year: 1984, infoURL: "https://en.wikipedia.org/wiki/Brooke_Knapp")]
    
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
