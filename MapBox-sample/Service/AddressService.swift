//
//  AddressService.swift
//  MapBox-sample
//
//  Created by Benjamin DUMONT on 24/02/2018.
//  Copyright © 2018 Benjamin DUMONT. All rights reserved.
//

import Foundation
import MapboxGeocoder

final class AddressService{
    
    func getAddresses(string: String, completion:@escaping ([Address])->Void) {
        let options = ForwardGeocodeOptions(query: string)
        
        options.allowedScopes = [.address, .pointOfInterest]
        let geocoder = Geocoder.shared
        
        geocoder.geocode(options) { (placemarks, attribution, error) in
            guard let placemarks = placemarks, placemarks.count > 0 else {
                completion([])
                return
            }
            let foundAddresses = placemarks.filter({$0.location != nil && $0.qualifiedName != nil && !($0.qualifiedName?.isEmpty)!})
            completion(foundAddresses.map{Address(mapBoxDic: $0.addressDictionary as! [String: Any], coordinate: $0.location!, printableAddress: $0.qualifiedName!)})
        }
    }
}
