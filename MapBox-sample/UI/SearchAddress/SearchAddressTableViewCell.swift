//
//  SearchAddressTableViewCell.swift
//  MapBox-sample
//
//  Created by Benjamin DUMONT on 24/02/2018.
//  Copyright © 2018 Benjamin DUMONT. All rights reserved.
//

import UIKit

class SearchAddressTableViewCell: UITableViewCell {
    @IBOutlet private weak var adressLabel: UILabel!
    var adress: Address! {
        didSet {
            adressLabel.text = adress.printableAddress
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
