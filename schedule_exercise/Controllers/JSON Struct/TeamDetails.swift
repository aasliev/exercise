//
//  TeamDetails.swift
//  schedule_exercise
//
//  Created by Asliddin Asliev on 11/13/20.
//

import Foundation

struct TeamDetails: Codable{
    var triCode : String?;
//    var fullName : String?;
    var name : String?;
//    var city : String?;
//    var record : String?;
//    var wins : String?;
//    var losses : String?;
//    var winPersentage : String?;
    
    enum CodingKeys : String, CodingKey {
        case triCode = "-TriCode";
//        case fullName = "-FullName";
        case name = "-Name";
//        case city = "-City";
//        case record = "-Record";
//        case wins = "-Wins";
//        case losses = "-Losses";
//        case winPersentage  = "-WinPercentage";
    }
}
