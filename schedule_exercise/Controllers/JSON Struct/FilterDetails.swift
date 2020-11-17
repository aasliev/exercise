//
//  FilterDetails.swift
//  schedule_exercise
//
//  Created by Asliddin Asliev on 11/13/20.

struct FilterDetails : Codable {
    let current : String?;
    
    enum CodingKeys : String, CodingKey {
        case current = "-Current"
    }
}
