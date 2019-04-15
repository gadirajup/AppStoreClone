//
//  AppsHorizontalController.swift
//  AppStoreClone
//
//  Created by Prudhvi Gadiraju on 4/9/19.
//  Copyright © 2019 Prudhvi Gadiraju. All rights reserved.


import UIKit

class AppsHorizontalView: UIView {
    
    fileprivate let cellId = "nestedCellId"
    
    var didSelectHandler: ((FeedResult?) -> ())?
    
    var appGroup : AppGroup? {
        didSet {
            collectionView.reloadData()
        }
    }
    
    var collectionView: UICollectionView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupCollectionView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setupCollectionView() {
        collectionView = UICollectionView(frame: frame, collectionViewLayout: SnappingCollectionFlowLayout())
        collectionView.backgroundColor = .white
        collectionView.register(AppRowCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.contentInset = .init(top: 0, left: 16, bottom: 0, right: 16)
        collectionView.decelerationRate = UICollectionView.DecelerationRate.fast
        
        addSubview(collectionView)
        collectionView.fillSuperview(padding: .init(top: 5, left: 0, bottom: 5, right: 0))
        
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
        }
    }
}

extension AppsHorizontalView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return appGroup?.feed.results.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! AppRowCell
        cell.cellData = appGroup?.feed.results[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: frame.width - 48, height: (frame.height - 20) / 3)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 2.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10.0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let app = appGroup?.feed.results[indexPath.item]
        didSelectHandler?(app)
    }
}
