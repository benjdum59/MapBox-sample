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
    
    var initialText: String = ""
    
    fileprivate var addresses: [Address] = []
    private let addressService = AddressService()
    private let disposeBag = DisposeBag()
    private let throttleInterval = 1.0
    
    weak var delegate: SearchAddressDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addressSearchBar.becomeFirstResponder()
        addressSearchBar.text = initialText
        if !initialText.isEmpty {
            getAddresses()
        }

        addressSearchBar.rx.text.throttle(throttleInterval, scheduler: MainScheduler.instance).subscribe(onNext: { [unowned self] query in
            self.getAddresses()
        }).disposed(by: disposeBag)
    }
    
    private func getAddresses(){
        self.addressService.getAddresses(string: self.addressSearchBar.text ?? "", completion: { (addresses) in
            self.addresses = addresses
            self.addressTableView.reloadData()
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
