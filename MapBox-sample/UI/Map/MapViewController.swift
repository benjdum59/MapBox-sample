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
import Hero

class MapViewController: UIViewController {
    
    @IBOutlet private weak var mapViewContainer: UIView!
    @IBOutlet fileprivate weak var adressSearchBar: UISearchBar!
    
    fileprivate let locationManager = CLLocationManager()
    fileprivate var mapContainer: MapContainer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        adressSearchBar.textField?.clearButtonMode = .never
        adressSearchBar.textField?.tintColor = UIColor.clear
        adressSearchBar.hero.id = Constants.Hero.searchBarId
        mapContainer = MapContainer(map: MapBoxImplementation(view: mapViewContainer, delegate: self))
        configureLocation()
    }
    
    private func configureLocation(){
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    fileprivate func showLocation(address: Address){
        mapContainer?.showLocation(location: CLLocationCoordinate2D(latitude: address.coordinate.latitude, longitude: address.coordinate.longitude))
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constants.Segue.searchAddress {
            let destVC = segue.destination as! SearchAddressViewController
            destVC.delegate = self
            destVC.initialText = adressSearchBar.text ?? ""
        }
    }
}

extension MapViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.last! as CLLocation
        mapContainer?.showLocation(location: location.coordinate)
        manager.stopUpdatingLocation()
    }
}

extension MapViewController: UISearchBarDelegate {
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        performSegue(withIdentifier: Constants.Segue.searchAddress, sender: self)
        return false
    }
}

extension MapViewController: SearchAddressDelegate {
    func didSelectAddress(address: Address) {
        showLocation(address: address)
        adressSearchBar.text = address.formattedAddress
    }
}

extension MapViewController: MGLMapViewDelegate {    
    //Called at the end of scroll.
    func mapView(_ mapView: MGLMapView, regionDidChangeWith reason: MGLCameraChangeReason, animated: Bool) {
        if reason.contains(MGLCameraChangeReason.gesturePan){
            dataManager.addressBLL.getAddress(coordinate: mapView.centerCoordinate, completion: { (address) in
                guard let address = address else {
                    return
                }
                self.adressSearchBar.text = address.formattedAddress
                self.showLocation(address: address)
            })
        }
    }
}


