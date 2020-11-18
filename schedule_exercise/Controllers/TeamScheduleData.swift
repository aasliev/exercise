//
//  TeamScheduleData.swift
//  schedule_exercise
//
//  Created by Asliddin Asliev on 11/14/20.
//

import Foundation

struct GameSections {
    var section : String?
    var games : [GameDetails]?
}

class TeamScheduleData {
    
    private let apiURL : String
    private var teamInfo : TeamDetails?
    private var gameSchedule  = [GameSections]()
    private var JSONData : GameList?
    private var currentYear : String?
    
    
    init(apiURL : String) {
        self.apiURL = apiURL
        loadJSONData { (result) in
            switch result{
            case .success(let data):
                self.parse(jsonData: data)
                self.setTeamInfo()
                self.setGameSchedule()
                self.setCurrentYear()
                print("init completed")
            case .failure(let error):
                print("Error loading data: \(error)")
            
            }
            
        }
    }
    
    // load JSON data from URL string
    private func loadJSONData(completion: @escaping (Result<Data,Error>) -> Void){
        if let url = URL(string: self.apiURL){
            URLSession(configuration: .default).dataTask(with: url){ (data, response, error) in
                if let error = error {
                    completion(.failure(error))
                }
                
                if let data = data {
                    completion(.success(data))
                }
            }.resume()
        }
    }
    
    // Parse JSON data to an object and save to JSONData variable
    private func parse(jsonData: Data) {
        do {
            let decodedData = try JSONDecoder().decode(GameList.self, from: jsonData)
            JSONData =  decodedData
        } catch let err{
            print(err)
        }
    }
     
    
    // set team info for easier use
    // for instance: if i need the full name of the team i can get it using
    // JSONData.gameList.team.fullName, creating separate Team variable makes it easier and less messy
    // teamInfo.fullName
    
    private func setTeamInfo(){
        if let data = JSONData?.gameList.team {
            teamInfo = data
        }
    }
    
    // set gameSchedude for the same reason as teamInfo
    // in case of gameSchedule i think it's more necessary because the structure
    // goes deaper
    
    private func setGameSchedule(){
        var gameArray  = [GameDetails]()
        if let sections = JSONData?.gameList.gameSection {
            for section in sections{
                var tmpSection : GameSections = GameSections()
                tmpSection.section = section.heading
                switch section.game {
                case .GameArray(let games):
                    tmpSection.games = games
                case .GameDictionary(let gameDict):
                    let gameDicttionary : GameDetails = gameDict
                    gameArray.append(gameDicttionary)
                    tmpSection.games = gameArray
                }
                gameSchedule.append(tmpSection)
        }
    }
    }
    
    func setCurrentYear(){
        if let year = JSONData?.gameList.filters.filter.current{
            currentYear = year
        }
    }

    
    func getGameSections ()->[GameSections]{
        return gameSchedule
    }
    
    func getTeamInfo () -> TeamDetails {
        if let teamInfo = teamInfo{
            return teamInfo
        }
        return TeamDetails()
    }
    
    func getCurrentYear()->String?{
        return currentYear
    }
    
//    func pringGameDetails(game: GameDetails){
//        print("--------------------------")
//        print("Type: \(game.type)")
//        print("Week: \(game.week)")
//        print("GameState: \(game.gameState ?? "")")
//        print("AwayScore: \(game.awayScore ?? "")")
//        print("HomeScore: \(game.homeScore ?? "")")
//        print("isHOme: \(game.isHome)")
//        print("date: \(game.date)")
//        print("Opponent: \(game.opponent)")
//    }
//
    
//    func printGameSections(){
//        for section in gameSchedule{
//            print("======================================================")
//            print(section.section!)
//            if let gameArray = section.games{
//                for game in gameArray{
//                    self.pringGameDetails(game: game)
//                }
//            }
//        }
//    }
//    
}
