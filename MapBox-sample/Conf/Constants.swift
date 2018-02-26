//
//  Constants.swift
//  MapBox-sample
//
//  Created by Benjamin DUMONT on 24/02/2018.
//  Copyright © 2018 Benjamin DUMONT. All rights reserved.
//

import Foundation

struct Constants {
    private init(){}
    struct MapBox {
        private init(){}
        static let url = URL(string: "mapbox://styles/mapbox/streets-v10")
        static let defaultZoom: Double = 16
    }
    struct Segue {
        private init(){}
        static let searchAddress = "searchAddress"
    }
    struct CellIdentifier {
        private init(){}
        static let searchAddressCell = "searchAddressCell"
    }
    struct Hero {
        private init(){}
        static let searchBarId = "searchBar"
    }
    struct Trads {
        private init(){}
        static let searchPlaceholder = "search_placeholder".localized
        static let searchResults = "search_results".localized
        static let searchHistory = "search_history".localized
    }
}
