//
//  AppRowCell.swift
//  AppStoreClone
//
//  Created by Prudhvi Gadiraju on 4/10/19.
//  Copyright © 2019 Prudhvi Gadiraju. All rights reserved.
//

import UIKit

class AppRowCell: UICollectionViewCell {
    
    // Properties
    
    var cellData: FeedResult? {
        didSet {
            nameLabel.text = cellData?.name
            companyLabel.text = cellData?.artistName
            
            if let imageUrl = cellData?.artworkUrl100 {
                imageView.load(imageWithUrl: imageUrl)
            }
        }
    }
    
    // UI Elements
    let imageView = UIImageView(cornerRadius: 8)
    let nameLabel = UILabel(text: "App Name", font: .systemFont(ofSize: 16))
    let companyLabel = UILabel(text: "Company Name", font: .systemFont(ofSize: 13))
    let getButton = UIButton(title: "GET")
    
    override init(frame: CGRect) {
        super.init(frame: frame)
     
        setupView()
    }
    
    fileprivate func setupView() {
        imageView.constrainWidth(constant: 64)
        imageView.constrainHeight(constant: 64)
        imageView.backgroundColor = .purple
        
        getButton.backgroundColor = .init(white: 0.95, alpha: 1)
        getButton.constrainHeight(constant: 32)
        getButton.constrainWidth(constant: 80)
        getButton.layer.cornerRadius = 16
        getButton.titleLabel?.font = .boldSystemFont(ofSize: 16)
        
        let labelStackView = UIStackView(arrangedSubviews: [nameLabel, companyLabel])
        labelStackView.axis = .vertical
        
        let stackView = UIStackView(arrangedSubviews: [imageView, labelStackView, getButton])
        stackView.alignment = .center
        stackView.spacing = 12
        
        addSubview(stackView)
        stackView.fillSuperview()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
