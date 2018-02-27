//
//  AddressHistoryStorage.swift
//  MapBox-sample
//
//  Created by Benjamin DUMONT on 25/02/2018.
//  Copyright © 2018 Benjamin DUMONT. All rights reserved.
//

import Foundation

final class AddressHistoryStorage: AddressStorageProtocol {
    private let keyStorage = "AddressHistoryStorage"
    private let userDefaults = UserDefaults.standard

    func getAddresses(completion:([Address]) -> Void) {
        guard let data = UserDefaults.standard.object(forKey: keyStorage) as? Data else {
            completion([])
            return
        }
        let decoded = NSKeyedUnarchiver.unarchiveObject(with: data) as! [Address]
        completion(decoded)
    }

    func saveAddresses(addresses: [Address], completion:() -> Void) {
        let data = NSKeyedArchiver.archivedData(withRootObject: addresses)
        userDefaults.set(data, forKey: keyStorage)
        completion()
    }

}
