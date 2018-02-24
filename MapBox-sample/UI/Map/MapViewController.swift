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
    fileprivate var currentPin : MGLAnnotation?
    
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
    
    fileprivate func showLocation(address: Address){
        guard let coordinate = address.coordinate else {
            return
        }
        showLocation(location: CLLocationCoordinate2D(latitude: coordinate.latitude, longitude: coordinate.longitude))
    }
    
    fileprivate func showLocation(location: CLLocationCoordinate2D) {
        mapView.setCenter(location, zoomLevel: Constants.MapBox.defaultZoom, animated: true)
        let pin = MGLPointAnnotation()
        pin.coordinate = location
        if currentPin != nil {
            mapView.removeAnnotation(currentPin!)
        }
        currentPin = pin
        mapView.addAnnotation(currentPin!)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constants.Segue.searchAddress {
            let destVC = segue.destination as! SearchAddressViewController
            destVC.delegate = self
        }
    }
}

extension MapViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.last! as CLLocation
        showLocation(location: location.coordinate)
    }
}

extension MapViewController: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        performSegue(withIdentifier: Constants.Segue.searchAddress, sender: self)
    }
}

extension MapViewController: SearchAddressDelegate {
    func didSelectAddress(address: Address) {
        showLocation(address: address)
    }
}

