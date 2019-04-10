//
//  SearchCell.swift
//  AppStoreClone
//
//  Created by Prudhvi Gadiraju on 4/8/19.
//  Copyright © 2019 Prudhvi Gadiraju. All rights reserved.
//

import UIKit

class SearchCell: UICollectionViewCell {
    
    // Properties
    
    
    // UI Elements
    
    let appIconImageView: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .red
        iv.widthAnchor.constraint(equalToConstant: 64).isActive = true
        iv.heightAnchor.constraint(equalTo: iv.widthAnchor).isActive = true
        iv.layer.cornerRadius = 14
        return iv
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "App Name"
        return label
    }()
    
    let categoryLabel: UILabel = {
        let label = UILabel()
        label.text = "Category"
        return label
    }()
    
    let ratingsLabel: UILabel = {
        let label = UILabel()
        label.text = "88M"
        return label
    }()
    
    let getButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Get", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 0.5)
        button.layer.cornerRadius = 14
        button.widthAnchor.constraint(equalToConstant: 80).isActive = true
        button.heightAnchor.constraint(equalToConstant: 32).isActive = true
        return button
    }()
    
    lazy var screenShot1ImageView = setupScreenShotImageView()
    lazy var screenShot2ImageView = setupScreenShotImageView()
    lazy var screenShot3ImageView = setupScreenShotImageView()
    
    // Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Setup
    
    fileprivate func setupView() {
        setupStackViews()
    }
    
    fileprivate func setupStackViews() {
        let labelsStackView = UIStackView(arrangedSubviews: [nameLabel, categoryLabel, ratingsLabel])
        labelsStackView.axis = .vertical
        
        let infoTopStackView = UIStackView(arrangedSubviews: [appIconImageView, labelsStackView, getButton ])
        infoTopStackView.axis = .horizontal
        infoTopStackView.spacing = 12
        infoTopStackView.alignment = .center
        
        let screenShotsStackView = UIStackView(arrangedSubviews: [screenShot1ImageView, screenShot2ImageView, screenShot3ImageView])
        screenShotsStackView.axis = .horizontal
        screenShotsStackView.spacing = 12
        screenShotsStackView.distribution = .fillEqually
        
        let overallStackView = UIStackView(arrangedSubviews: [infoTopStackView, screenShotsStackView])
        overallStackView.axis = .vertical
        overallStackView.spacing = 12
        
        addSubview(overallStackView)
        overallStackView.fillSuperview(padding: .init(top: 16, left: 16, bottom: 0, right: 16))
    }
    
    func setupScreenShotImageView() -> UIImageView {
        let iv = UIImageView()
        iv.backgroundColor = .blue
        return iv
    }
}
