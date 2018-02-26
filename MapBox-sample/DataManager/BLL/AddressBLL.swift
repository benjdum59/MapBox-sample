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
    private let addressStorage: AddressStorageProtocol
    private let addressService: AddressServiceProtocol
    
    init() {
        addressStorage = AddressHistoryStorage()
        addressService = AddressService()
    }
    
    init(storage: AddressStorageProtocol, service: AddressServiceProtocol) {
        addressStorage = storage
        addressService = service
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
            var addresses = addresses
            addresses.add(address: address, maxElements: 2)
            addressStorage.saveAddresses(addresses: addresses, completion: {
                completion()
            })
        }
        
    }
    
    
}
