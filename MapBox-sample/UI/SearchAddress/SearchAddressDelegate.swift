//
//  SearchAddressDelegate.swift
//  MapBox-sample
//
//  Created by Benjamin DUMONT on 24/02/2018.
//  Copyright © 2018 Benjamin DUMONT. All rights reserved.
//

import Foundation

protocol SearchAddressDelegate: class {
    func didSelectAddress(address: Address)
}
