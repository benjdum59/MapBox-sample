//
//  ViewController.swift
//  MapBox-sample
//
//  Created by Benjamin DUMONT on 24/02/2018.
//  Copyright © 2018 Benjamin DUMONT. All rights reserved.
//

import UIKit
import Mapbox

class MapViewController: UIViewController {
    
    @IBOutlet private weak var mapViewContainer: UIView!
    
    fileprivate var mapView: MGLMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureMapView()
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


}

