//
//  AddressService.swift
//  MapBox-sample
//
//  Created by Benjamin DUMONT on 24/02/2018.
//  Copyright © 2018 Benjamin DUMONT. All rights reserved.
//

import Foundation
import MapboxGeocoder

final class AddressService: AddressServiceProtocol {
    private let geocoder = Geocoder.shared

    func searchAddresses(string: String, completion:@escaping ([Address]) -> Void) {
        let options = ForwardGeocodeOptions(query: string)
        options.allowedScopes = [.address, .pointOfInterest]
        geocoder.geocode(options) { (placemarks, attribution, error) in
            guard let placemarks = placemarks, placemarks.count > 0 else {
                completion([])
                return
            }
            let foundAddresses = placemarks.filter({$0.location != nil && $0.qualifiedName != nil && !($0.qualifiedName?.isEmpty)!})
            completion(foundAddresses.map {Address(mapBoxDic: $0.addressDictionary as! [String: Any], coordinate: $0.location!, printableAddress: $0.qualifiedName!)})
        }
    }
    
    func getAddress(coordinate:CLLocationCoordinate2D, completion:@escaping (Address?) -> Void) {
        let options = ReverseGeocodeOptions(coordinate: coordinate)
        
        geocoder.geocode(options) { (placemarks, attribution, error) in
            guard let placemark = placemarks?.first else {
                completion(nil)
                return
            }
            let location = Coordinate(latitude: coordinate.latitude, longitude: coordinate.longitude)
            completion(Address(mapBoxDic: placemark.addressDictionary as! [String: Any], coordinate: location, printableAddress: placemark.qualifiedName ?? ""))
        }
    }

}
