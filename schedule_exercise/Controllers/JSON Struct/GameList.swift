//
//  GameList.swift
//  schedule_exercise
//
//  Created by Asliddin Asliev on 11/13/20.
//

/*
 Divided JSON struct to smaller parts (and separate files) for better readability.
 
 */



import Foundation

struct GameSectionDetail: Codable {
    var heading : String?
    var game :  GameUnion
    
    enum CodingKeys : String, CodingKey {
        case heading = "-Heading";
        case game = "Game";
    }
    
}




enum GameUnion : Codable {
    case GameArray([GameDetails])
    case GameDictionary(GameDetails)
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode([GameDetails].self){
            self = .GameArray(x)
            return
        }
        if let x = try? container.decode(GameDetails.self){
            self = .GameDictionary(x)
            return
        }
        throw DecodingError.typeMismatch(GameUnion.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for GameUnion"))
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .GameArray(let x):
            try container.encode(x)
        case .GameDictionary(let x):
            try container.encode(x)
        }
    }
}


struct Filters : Codable{
    let filter : FilterDetails;
    
    enum CodingKeys : String, CodingKey {
        case filter = "Filter"
    }
}

struct GameListDetails : Decodable{
    let team : TeamDetails;
    let gameSection : [GameSectionDetail];
    let filters : Filters;
    
    enum CodingKeys : String, CodingKey {
        case team = "Team"
        case gameSection = "GameSection"
        case filters = "Filters"
    }
}
// MARK: - Structure of the JSON
struct GameList : Decodable {
    let gameList : GameListDetails
    
    enum CodingKeys : String, CodingKey {
        case gameList = "GameList"
    }
}


