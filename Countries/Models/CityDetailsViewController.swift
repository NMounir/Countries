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
        centerMapOnLocation(location: CLLocation(latitude: (city?.coordinate.latitude)!, longitude: (city?.coordinate.longitude)!))
    }
    
    //center the map camera to the given location with region radius
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, 1000, 1000)
        mapView.setRegion(coordinateRegion, animated: true)
        //add annotation marker on the map for the city location
        if let cityDetail = city {
            addCityAnnotationOnMap(city: cityDetail)
        }
    }
    
    func addCityAnnotationOnMap(city: City){
        mapView.addAnnotation(city)
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

// MARK: - MKMapViewDelegate
extension CityDetailsViewController: MKMapViewDelegate {
    
    // return the view for each annotation
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        guard let annotation = annotation as? City else { return nil }
        
        let identifier = "marker"
        var view: MKMarkerAnnotationView
        
        // reuses annotation views that are no longer visible
        if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
            as? MKMarkerAnnotationView {
            dequeuedView.annotation = annotation
            view = dequeuedView
        } else {
            view = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            view.canShowCallout = true
            view.calloutOffset = CGPoint(x: -5, y: 5)
            view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }
        return view
    }
}
