//
//  AddressStorageProtocol.swift
//  MapBox-sample
//
//  Created by Benjamin DUMONT on 25/02/2018.
//  Copyright © 2018 Benjamin DUMONT. All rights reserved.
//

import Foundation

protocol AddressStorageProtocol {
    
    func getAddresses(completion:([Address])->Void)
    func saveAddresses(addresses: [Address], completion:()->Void)
}
