//
//  City.swift
//  Countries
//
//  Created by Nora Mounir on 6/23/18.
//  Copyright © 2018 nmounir. All rights reserved.
//

import Foundation
import MapKit

class City : NSObject, Decodable, MKAnnotation{
    let name : String
    let country : String
    let id : Int?
    let coord : Coordinate?
    
    init(city: String, country: String, id: Int, coordinate: Coordinate) {
        self.name = city
        self.country = country
        self.id = id
        self.coord = coordinate
        super.init()
    }
    //To conform to protocol MKAnnotation, we need to define coordinate property along with title and subtitle
    var coordinate: CLLocationCoordinate2D{

        if let lat = coord?.latitude, let  long = coord?.longitude{
            return CLLocationCoordinate2D(latitude: lat, longitude: long)
        }
        return CLLocationCoordinate2D(latitude: 52.3702, longitude: 4.8952)
    }
    var title: String?{
        return name
    }
    var subtitle: String?{
        return country
    }
    
    private enum CodingKeys : String, CodingKey {
        case id = "_id"
        case name, country, coord
    }
    
    //Define an equality function to compare between 2 cities
    static func ==(lhs: City, rhs: City) -> Bool {
        return lhs.id == rhs.id
    }
}

struct Coordinate : Decodable{
    
    let latitude : Double?
    let longitude : Double?
    
    init(latitude: Double, longitude: Double) {
        self.latitude = latitude
        self.longitude = longitude
    }
    
    private enum CodingKeys : String, CodingKey {
        case latitude = "lat"
        case longitude = "lon"
    }
}



