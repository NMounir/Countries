//
//  CountriesTests.swift
//  CountriesTests
//
//  Created by Nora Mounir on 6/23/18.
//  Copyright © 2018 nmounir. All rights reserved.
//

import XCTest

@testable import Countries

class CountriesTests: XCTestCase {
    var cities = [City]()
    var filtered_1 = [City]()
    var filtered_2 = [City]()
    var filtered_3 = [City]()
    
    let cityListViewController = CityListViewController()
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        cities = [
            City(city: "Alabama", country: "US", id: 123, coordinate: Coordinate(latitude: 52.3702, longitude: 4.8952)),
            City(city: "Albuquerque", country: "US", id: 123, coordinate: Coordinate(latitude: 52.3702, longitude: 4.8952)),
            City(city: "Anaheim", country: "US", id: 123, coordinate: Coordinate(latitude: 52.3702, longitude: 4.8952)),
            City(city: "Arizona", country: "US", id: 123, coordinate: Coordinate(latitude: 52.3702, longitude: 4.8952)),
            City(city: "Sydney", country: "AU", id: 123, coordinate: Coordinate(latitude: 52.3702, longitude: 4.8952))
        ]
        
        filtered_1 = [
            City(city: "Alabama", country: "US", id: 123, coordinate: Coordinate(latitude: 52.3702, longitude: 4.8952)),
            City(city: "Albuquerque", country: "US", id: 123, coordinate: Coordinate(latitude: 52.3702, longitude: 4.8952)),
            City(city: "Anaheim", country: "US", id: 123, coordinate: Coordinate(latitude: 52.3702, longitude: 4.8952)),
            City(city: "Arizona", country: "US", id: 123, coordinate: Coordinate(latitude: 52.3702, longitude: 4.8952)),
        ]
        
        filtered_2 = []
        
        filtered_3 = [
            City(city: "Alabama", country: "US", id: 123, coordinate: Coordinate(latitude: 52.3702, longitude: 4.8952)),
            City(city: "Albuquerque", country: "US", id: 123, coordinate: Coordinate(latitude: 52.3702, longitude: 4.8952)),
        ]
    }
    
    func searchWithValue(value: String) -> [City]{
        return cityListViewController.filterCitiesForSearchText(value, cities)
    }
    
    func testSearchCityForInput1(){
        let results = searchWithValue(value:"A")
        XCTAssertEqual(results.map{$0.name}, filtered_1.map{$0.name})
    }
    
    func testSearchCityForInput2(){
       let results = searchWithValue(value:"_")
        XCTAssertEqual(results.map{$0.name}, filtered_3.map{$0.name}) //This case only to test the unit test!
    }
    
    func testSearchCityForInput3(){
        let results = searchWithValue(value:" ")
        XCTAssertEqual(results.map{$0.name}, filtered_2.map{$0.name})
    }
    
    func testSearchCityForInput4(){
        let results = searchWithValue(value:"AL")
        XCTAssertEqual(results.map{$0.name}, filtered_3.map{$0.name})
    }
    
    func testSearchCityForInput5(){
        let results = searchWithValue(value:"a")
        XCTAssertEqual(results.map{$0.name}, filtered_1.map{$0.name})
    }
    
    func testSearchCityForInput6(){
        let results = searchWithValue(value:"")
        XCTAssertEqual(results.map{$0.name}, cities.map{$0.name})
    }
}

