//
//  MapBoxImplementation.swift
//  MapBox-sample
//
//  Created by Benjamin DUMONT on 25/02/2018.
//  Copyright © 2018 Benjamin DUMONT. All rights reserved.
//

import UIKit
import Mapbox


class MapBoxImplementation: MapProtocol {

    var mapView: MGLMapView!

    required init(view: UIView, delegate: Any? = nil) {
        mapView = MGLMapView(frame: view.bounds, styleURL: Constants.MapBox.url)
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        mapView.allowsScrolling = true
        mapView.allowsZooming = true
        mapView.delegate = delegate as? MGLMapViewDelegate
        view.addSubview(mapView)
    }

    func showLocation(location: CLLocationCoordinate2D) {
        mapView.setCenter(location, zoomLevel: Constants.MapBox.defaultZoom, animated: true)
        let pin = MGLPointAnnotation()
        pin.coordinate = location
        mapView.addAnnotation(pin)
    }

}
