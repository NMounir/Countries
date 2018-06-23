//
//  City.swift
//  Countries
//
//  Created by Nora Mounir on 6/23/18.
//  Copyright © 2018 nmounir. All rights reserved.
//

import Foundation

struct City : Decodable, CustomStringConvertible {
    let name : String
    let country : String
    let id : Int?
    let coordinate : Coordinate?
    
    var description: String {
        return "\(self.name) \(self.country)"
    }

    private enum CodingKeys : String, CodingKey {
        case id = "_id"
        case coordinate = "coord"
        case name, country
    }
}

struct Coordinate : Decodable {
    let latitude : Double?
    let longitude : Double?
    
    private enum CodingKeys : String, CodingKey {
        case latitude = "lat"
        case longitude = "lon"
    }
}
