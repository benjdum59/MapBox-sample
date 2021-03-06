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
        configureSearchBar()
        mapContainer = MapContainer(map: MapBoxImplementation(view: mapViewContainer, delegate: self))
        configureLocation()
    }
    
    private func configureSearchBar(){
        adressSearchBar.textField?.clearButtonMode = .never
        adressSearchBar.textField?.tintColor = UIColor.clear
        adressSearchBar.placeholder = Constants.Trads.searchPlaceholder
        adressSearchBar.hero.id = Constants.Hero.searchBarId
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
    
    fileprivate func presentAlert(){
        let alert = UIAlertController(title: Constants.Trads.alertTitle, message: Constants.Trads.alertMessage, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: Constants.Trads.ok, style: .default) { (action) in
            self.configureLocation()
        }
        let settingsAction = UIAlertAction(title: Constants.Trads.alertSettings, style: .default) { (_) -> Void in
            guard let settingsUrl = URL(string: UIApplicationOpenSettingsURLString) else {
                return
            }
            if UIApplication.shared.canOpenURL(settingsUrl) {
                if #available(iOS 10.0, *) {
                    UIApplication.shared.open(settingsUrl, completionHandler: { (success) in
                    })
                } else {
                    UIApplication.shared.openURL(settingsUrl)
                    self.presentAlert()
                }
            }
        }
        alert.addAction(settingsAction)
        alert.addAction(alertAction)
        present(alert, animated: true, completion: nil)
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
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        presentAlert()
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


