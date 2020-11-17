//
//  TeamDetails.swift
//  schedule_exercise
//
//  Created by Asliddin Asliev on 11/13/20.
//

import Foundation

struct TeamDetails: Codable{
    var triCode : String?;
    var name : String?;
    
    enum CodingKeys : String, CodingKey {
        case triCode = "-TriCode";
        case name = "-Name";
    }
}
