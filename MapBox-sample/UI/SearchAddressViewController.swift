//
//  SearchAddressViewController.swift
//  MapBox-sample
//
//  Created by Benjamin DUMONT on 24/02/2018.
//  Copyright © 2018 Benjamin DUMONT. All rights reserved.
//

import UIKit
import MapboxGeocoder

class SearchAddressViewController: UIViewController {
    @IBOutlet weak var addressSearchBar: UISearchBar!
    
    fileprivate var addresses: [Address] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addressSearchBar.becomeFirstResponder()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func getAdresses(){
        let options = ForwardGeocodeOptions(query: "165 avenue de Bretagne, 59000 Lille")
        
        options.allowedScopes = [.address, .pointOfInterest]
        let geocoder = Geocoder.shared
        
        geocoder.geocode(options) { (placemarks, attribution, error) in
            guard let placemarks = placemarks, placemarks.count > 0 else {
                self.addresses = []
                return
            }
            let foundAddresses = placemarks.filter({$0.location != nil && $0.qualifiedName != nil && !($0.qualifiedName?.isEmpty)!})
            self.addresses = foundAddresses.map{Address(mapBoxDic: $0.addressDictionary as! [String: Any], coordinate: $0.location!, printableAddress: $0.qualifiedName!)}
        }
    }

}

extension SearchAddressViewController: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        dismiss(animated: true, completion: nil)
    }
}
