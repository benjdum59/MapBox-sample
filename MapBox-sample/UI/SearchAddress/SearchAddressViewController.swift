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
import Hero

class SearchAddressViewController: UIViewController {
    @IBOutlet weak var addressSearchBar: UISearchBar!
    @IBOutlet weak var addressTableView: UITableView!

    var initialText: String = ""

    fileprivate var addresses: [Address] = []
    fileprivate var history: [Address] = []

    private let disposeBag = DisposeBag()
    private let throttleInterval = 1.0

    weak var delegate: SearchAddressDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.hero.isEnabled = true
        addressSearchBar.hero.id = Constants.Hero.searchBarId
        addressTableView.hero.modifiers = [.translate(y:UIScreen.main.bounds.size.height - addressSearchBar.frame.size.height)]
        addressSearchBar.text = initialText
        dataManager.addressBLL.getAddressHistory { (addresses) in
            history = addresses.reversed()
            getAddresses()
        }

        addressSearchBar.rx.text.throttle(throttleInterval, scheduler: MainScheduler.instance).subscribe(onNext: { [unowned self] query in
            self.getAddresses()
        }).disposed(by: disposeBag)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        addressSearchBar.becomeFirstResponder()
    }
    
    private func getAddresses() {
        dataManager.addressBLL.searchAddress(string: self.addressSearchBar.text ?? "") { (addresses) in
            self.addresses = addresses
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
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return history.count > 0 ? 2 : 1
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return section == tableView.numberOfSections - 1 ? Constants.Trads.searchResults : Constants.Trads.searchHistory
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (section == tableView.numberOfSections - 1) ? addresses.count : history.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.CellIdentifier.searchAddressCell) as! SearchAddressTableViewCell
        cell.adress = indexPath.section == tableView.numberOfSections - 1 ? addresses[indexPath.row] : history[indexPath.row]
        return cell
    }

}

extension SearchAddressViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let address = (indexPath.section == tableView.numberOfSections - 1) ? addresses[indexPath.row] : history[indexPath.row]
        delegate?.didSelectAddress(address: address)
        dataManager.addressBLL.saveAddress(address: address) {
            dismiss(animated: true, completion: nil)
        }
    }

}
