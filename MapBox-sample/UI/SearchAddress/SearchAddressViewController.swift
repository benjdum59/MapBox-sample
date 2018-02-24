//
//  SearchAddressViewController.swift
//  MapBox-sample
//
//  Created by Benjamin DUMONT on 24/02/2018.
//  Copyright © 2018 Benjamin DUMONT. All rights reserved.
//

import UIKit
import MapboxGeocoder
import RxCocoa
import RxSwift

class SearchAddressViewController: UIViewController {
    @IBOutlet weak var addressSearchBar: UISearchBar!
    @IBOutlet weak var addressTableView: UITableView!
    
    fileprivate var addresses: [Address] = []

    private let disposeBag = DisposeBag()
    private let throttleInterval = 1.0
    
    weak var delegate: SearchAddressDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addressSearchBar.becomeFirstResponder()

        addressSearchBar.rx.text.throttle(throttleInterval, scheduler: MainScheduler.instance).subscribe(onNext: { [unowned self] query in
            self.getAdresses(text: self.addressSearchBar.text ?? "")
        }).disposed(by: disposeBag)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func getAdresses(text: String){
        let options = ForwardGeocodeOptions(query: text)
        
        options.allowedScopes = [.address, .pointOfInterest]
        let geocoder = Geocoder.shared
        
        geocoder.geocode(options) { (placemarks, attribution, error) in
            guard let placemarks = placemarks, placemarks.count > 0 else {
                self.addresses = []
                return
            }
            let foundAddresses = placemarks.filter({$0.location != nil && $0.qualifiedName != nil && !($0.qualifiedName?.isEmpty)!})
            self.addresses = foundAddresses.map{Address(mapBoxDic: $0.addressDictionary as! [String: Any], coordinate: $0.location!, printableAddress: $0.qualifiedName!)}
            self.addressTableView.reloadData()
        }
    }
}

extension SearchAddressViewController: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        dismiss(animated: true, completion: nil)
    }
}

extension SearchAddressViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return addresses.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.CellIdentifier.searchAddressCell) as! SearchAddressTableViewCell
        cell.adress = addresses[indexPath.row]
        return cell
    }
}

extension SearchAddressViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let address = addresses[indexPath.row]
        delegate?.didSelectAddress(address: address)
        dismiss(animated: true, completion: nil)
    }
}
