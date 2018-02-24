//
//  SearchAddressViewController.swift
//  MapBox-sample
//
//  Created by Benjamin DUMONT on 24/02/2018.
//  Copyright © 2018 Benjamin DUMONT. All rights reserved.
//

import UIKit

class SearchAddressViewController: UIViewController {
    @IBOutlet weak var addressSearchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addressSearchBar.becomeFirstResponder()

        // Do any additional setup after loading the view.
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
