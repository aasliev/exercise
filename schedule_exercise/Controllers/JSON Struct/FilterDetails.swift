////
////  FilterDetails.swift
////  schedule_exercise
////
////  Created by Asliddin Asliev on 11/13/20.
////
//
//import Foundation
//
//struct FilterItemArray: Codable {
//    let items : [FilterItem]
//    
//    enum CodingKeys : String , CodingKey {
//        case items = "Items"
//    }
//}
//
//struct FilterItem: Codable {
//    let id : String?;
//    let name : String?;
//    
//    enum CodingKeys : String, CodingKey {
//        case id = "-Id"
//        case name = "-Name"
//    }
//}
//
struct FilterDetails : Codable {
//    let name : String?;
//    let queryParameter : String?;
//    let placeholder : String?;
    let current : String?;
//    let filterItems : FilterItemArray;
    
    enum CodingKeys : String, CodingKey {
//        case name = "-Name";
//        case queryParameter = "-QueryParameter";
//        case placeholder = "-Placeholder";
        case current = "-Current";
//        case filterItems = "FilterItems";
    }
}
