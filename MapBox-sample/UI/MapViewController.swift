//
//  ViewController.swift
//  MapBox-sample
//
//  Created by Benjamin DUMONT on 24/02/2018.
//  Copyright © 2018 Benjamin DUMONT. All rights reserved.
//

import UIKit
import Mapbox
import CoreLocation

class MapViewController: UIViewController {
    
    @IBOutlet private weak var mapViewContainer: UIView!
    
    fileprivate var mapView: MGLMapView!
    fileprivate let locationManager = CLLocationManager()
    fileprivate var currentCoordinate: CLLocationCoordinate2D?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureMapView()
        configureLocation()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func configureMapView(){
        mapView = MGLMapView(frame: mapViewContainer.bounds, styleURL: Constants.MapBox.url)
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        mapViewContainer.addSubview(mapView)
    }
    
    private func configureLocation(){
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    fileprivate func showUserLocation(){
        guard let coordinate = currentCoordinate else {
            return
        }
        mapView.setCenter(coordinate, zoomLevel: Constants.MapBox.defaultZoom, animated: true)
        let pin = MGLPointAnnotation()
        pin.coordinate = coordinate
        mapView.addAnnotation(pin)
    }


}

extension MapViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.last! as CLLocation
        currentCoordinate = location.coordinate
        locationManager.stopUpdatingLocation()
        showUserLocation()
    }
}

