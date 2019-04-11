//
//  UIButton+Init.swift
//  AppStoreClone
//
//  Created by Prudhvi Gadiraju on 4/10/19.
//  Copyright © 2019 Prudhvi Gadiraju. All rights reserved.
//

import UIKit

extension UIButton {
    convenience init(title: String) {
        self.init(type: .system)
        setTitle(title, for: .normal)
    }
}
