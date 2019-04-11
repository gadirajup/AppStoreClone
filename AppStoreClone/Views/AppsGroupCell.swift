//
//  AppsGroupCell.swift
//  AppStoreClone
//
//  Created by Prudhvi Gadiraju on 4/9/19.
//  Copyright © 2019 Prudhvi Gadiraju. All rights reserved.
//

import UIKit

class AppsGroupCell: UICollectionViewCell {
    
    // Properties
    
    // UI Elements
    let titleLabel = UILabel(text: "App Section", font: .systemFont(ofSize: 30))
    var horizontalCollectionView: AppsHorizontalView!
    
    // Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
        setupLabel()
        setupCollectionView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Setup
    
    fileprivate func setupCollectionView() {
        horizontalCollectionView = AppsHorizontalView(frame: frame)
        addSubview(horizontalCollectionView)
        horizontalCollectionView.anchor(top: titleLabel.bottomAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor)
    }
    
    fileprivate func setupLabel() {
        addSubview(titleLabel)
        titleLabel.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 16, left: 16, bottom: 0, right: 0))
    }
    
    fileprivate func setupView() {
        backgroundColor = .white
    }
}
