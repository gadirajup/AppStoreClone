//
//  AppsHeaderCell.swift
//  AppStoreClone
//
//  Created by Prudhvi Gadiraju on 4/10/19.
//  Copyright © 2019 Prudhvi Gadiraju. All rights reserved.
//

import UIKit

class AppsHeaderCell: UICollectionViewCell {
    
    var header: AppHeader? {
        didSet {
            companyLabel.text = header?.name
            label.text = header?.tagline
            
            if let imageUrl = header?.imageUrl {
                imageView.load(imageWithUrl: imageUrl)
            }
        }
    }
    
    // UI Elements
    
    let companyLabel: UILabel = {
        let label = UILabel(text: "Facebook", font: .systemFont(ofSize: 14, weight: .bold))
        label.textColor = #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)
        return label
    }()
    
    let label: UILabel = {
        let label = UILabel(text: "Keeping up with friends is better than ever", font: .systemFont(ofSize: 30, weight: .regular))
        label.numberOfLines = -1
        return label
    }()
    
    let imageView: UIImageView = {
        let iv = UIImageView(cornerRadius: 20)
        iv.backgroundColor = .blue
        iv.clipsToBounds = true
        return iv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setupView() {
        addSubview(companyLabel)
        companyLabel.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 8, left: 0, bottom: 0, right: 0))
        
        addSubview(label)
        label.anchor(top: companyLabel.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 8, left: 0, bottom: 0, right: 0))
        
        addSubview(imageView)
        imageView.anchor(top: label.bottomAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 8, left: 0, bottom: 0, right: 0))
    }
}
