//
//  UISearchBar+Utils.swift
//  MapBox-sample
//
//  Created by Benjamin DUMONT on 24/02/2018.
//  Copyright © 2018 Benjamin DUMONT. All rights reserved.
//

import UIKit

extension UISearchBar {
    var textField : UITextField?{
        return self.value(forKey: "_searchField") as? UITextField
    }
}
