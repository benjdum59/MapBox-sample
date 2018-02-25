//
//  AddressBLL.swift
//  MapBox-sample
//
//  Created by Benjamin DUMONT on 25/02/2018.
//  Copyright © 2018 Benjamin DUMONT. All rights reserved.
//

import Foundation
import CoreLocation

class AddressBLL {
    private let addressStorage: AddressHistoryStorage
    private let addressService: AddressService
    
    init() {
        addressStorage = AddressHistoryStorage()
        addressService = AddressService()
    }
    
    func searchAddress(string: String, completion:@escaping ([Address])->Void) {
        addressService.searchAddresses(string: string) { (addresses) in
            completion(addresses)
        }
    }
    
    func getAddress(coordinate:CLLocationCoordinate2D, completion:@escaping (Address?)->Void) {
        addressService.getAddress(coordinate: coordinate) { (address) in
            guard let address = address else {
                completion(nil)
                return
            }
            self.saveAddress(address: address, completion: {
                completion(address)
            })
        }
    }
    
    func getAddressHistory(completion: ([Address])->Void){
        addressStorage.getAddresses { (addresses) in
            completion(addresses)
        }
    }
    
    func saveAddress(address: Address, completion:()->Void) {
        addressStorage.getAddresses { (addresses) in
            var filteredAddresses = addresses.filter({$0.coordinate.latitude != address.coordinate.latitude || $0.coordinate.longitude != address.coordinate.longitude})
            if filteredAddresses.count < 2 {
                filteredAddresses.append(address)
            } else {
                filteredAddresses.remove(at: 0)
                filteredAddresses.append(address)
            }
            addressStorage.saveAddresses(addresses: filteredAddresses, completion: {
                completion()
            })
        }
        
    }
    
    
}
