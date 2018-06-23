//
//  CityDetailsViewController.swift
//  Countries
//
//  Created by Nora Mounir on 6/23/18.
//  Copyright © 2018 nmounir. All rights reserved.
//

import UIKit
import MapKit

class CityDetailsViewController: UIViewController {
    
    @IBOutlet weak var mapView : MKMapView!
    var city: City? {
        didSet {
            configureCityView()
        }
    }
    
    func configureCityView() {
        
        if (!self.isViewLoaded) {
            return
        }
        
        //set the screen title to the current city
        self.title = city?.name
        
        //center the map on the city location otherwise set the default map center to Amsterdam coordinates
        if let latitude = city?.coordinate?.latitude, let longitude = city?.coordinate?.longitude {
            let cityLocation = CLLocation(latitude: latitude, longitude: longitude)
            centerMapOnLocation(location: cityLocation)
        }else{
            let cityLocation = CLLocation(latitude: 52.3702, longitude: 4.8952)
            centerMapOnLocation(location: cityLocation)
        }
    }
    
    //center the map camera to the given location with region radius
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
                                                                  1000, 1000)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    // MARK: - View Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCityView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
