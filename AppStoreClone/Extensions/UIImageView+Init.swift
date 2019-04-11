//
//  UIImageView+Init.swift
//  AppStoreClone
//
//  Created by Prudhvi Gadiraju on 4/10/19.
//  Copyright © 2019 Prudhvi Gadiraju. All rights reserved.
//

import UIKit

extension UIImageView {
    convenience init (cornerRadius: CGFloat) {
        self.init(image: nil)
        layer.cornerRadius = cornerRadius
        clipsToBounds = true
        contentMode = .scaleAspectFill
    }
}
