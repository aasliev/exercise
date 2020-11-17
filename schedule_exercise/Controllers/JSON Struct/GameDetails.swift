//
//  GameDetails.swift
//  schedule_exercise
//
//  Created by Asliddin Asliev on 11/13/20.
//

import Foundation

// MARK: - Game Details Struct
struct DateDetails: Codable{
    var timestamp, time, text : String
    
    enum CodingKeys : String, CodingKey {
        case text = "-Text"
        case time = "-Time"
        case timestamp = "-Timestamp"
    }
}

struct OpponentDetails : Codable{
    var triCode, fullName, name : String
    enum CodingKeys : String, CodingKey {
        case triCode = "-TriCode"
        case fullName = "-FullName"
        case name = "-Name"
    }
    
}


struct GameDetails: Codable{
    var type, week, isHome : String
    var gameState, awayScore, homeScore : String?
    var date : DateDetails?
    var opponent : OpponentDetails?
    
    enum CodingKeys : String, CodingKey {
        case type  = "-Type"
        case week = "-Week"
        case gameState = "-GameState"
        case awayScore = "-AwayScore"
        case homeScore = "-HomeScore"
        case isHome = "-IsHome"
        case date = "Date"
        case opponent = "Opponent"
    }
    
    
}

