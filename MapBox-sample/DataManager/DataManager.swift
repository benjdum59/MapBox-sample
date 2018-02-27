//
//  DataManager.swift
//  MapBox-sample
//
//  Created by Benjamin DUMONT on 25/02/2018.
//  Copyright © 2018 Benjamin DUMONT. All rights reserved.
//

import Foundation

class DataManager {
    let addressBLL : AddressBLL

    init() {
        addressBLL = AddressBLL()
    }

    init(storage: AddressStorageProtocol, service: AddressServiceProtocol) {
        addressBLL = AddressBLL(storage: storage, service: service)
    }
}
