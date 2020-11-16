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
//    var numeric, text, time, timestamp : String
    //var isTBA, isTba : String
    
    enum CodingKeys : String, CodingKey {
//        case numeric = "-Numeric"
        case text = "-Text"
        case time = "-Time"
        case timestamp = "-Timestamp"
        //case isTBA = "-IsTBA"
        //case isTba = "-IsTba"
    }
}

struct OpponentDetails : Codable{
    var triCode, fullName, name : String
    //var city, record : String
    
    enum CodingKeys : String, CodingKey {
        case triCode = "-TriCode"
        case fullName = "-FullName"
        case name = "-Name"
        //case city = "-City"
        //case record = "-Record"
    }
    
}


//struct TicketsDetail: Codable{
//    var hasLink : String
//
//    enum CodingKeys : String, CodingKey {
//        case hasLink = "-HasLink";
//    }
//}

//struct ButtonDetails : Codable{
//    var title, url, imageUrl : String
//
//    enum CodingKeys : String, CodingKey {
//        case title = "Title";
//        case url = "URL";
//        case imageUrl = "ImageURL";
//    }
//}

//struct Button : Codable {
//    var button : ButtonDetails
//
//    enum CodingKeys: String, CodingKey{
//        case button = "Button";
//    }
//}

//struct CardData : Codable {
//    var clickThroughUrl : String
//    var isDefault : String
//
//    enum CodingKeys : String, CodingKey {
//        case clickThroughUrl = "ClickthroughURL";
//        case isDefault = "IsDefault";
//    }
//}

struct GameDetails: Codable{
    var type, week, isHome : String
    var gameState, awayScore, homeScore : String?
    //var type,home,week,label, isHome : String
    //var result, venue, WLT : String?
    //var gameState, clock, awayScore, homeScore, down : String?
    //var scheduleHeader : String?
    var date : DateDetails?
    var opponent : OpponentDetails?
    //var tickets : TicketsDetail?
    //var buttons : Button?
    //var cardData : CardData
    
    enum CodingKeys : String, CodingKey {
//        case id = "-Id"
        case type  = "-Type"
        //case result  = "-Result"
//        case home = "-Home"
        case week = "-Week"
        //case label = "-Label"
        //case venue = "-Venue"
        //case WLT = "-WLT"
        case gameState = "-GameState"
        //case clock = "-Clock"
        case awayScore = "-AwayScore"
        case homeScore = "-HomeScore"
        //case down = "-Down"
        case isHome = "-IsHome"
        //case scheduleHeader = "-ScheduleHeader"
        case date = "Date"
        case opponent = "Opponent"
        //case tickets = "Tickets"
        //case buttons = "Buttons"
        //case cardData = "CardData"
        
    }
    
    
}

