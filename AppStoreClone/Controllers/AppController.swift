//
//  AppController.swift
//  AppStoreClone
//
//  Created by Prudhvi Gadiraju on 4/9/19.
//  Copyright © 2019 Prudhvi Gadiraju. All rights reserved.
//

import UIKit

class AppController: UICollectionViewController {
    
    // Properties
    fileprivate let cellId = "cellId"
    fileprivate let headerId = "headerId"
    fileprivate var topApps: AppGroup?
    var groups = [AppGroup]()
    var headerHeight: CGFloat = 0
    
    let activitySpinnerView: UIActivityIndicatorView = {
        let ai = UIActivityIndicatorView(style: .whiteLarge)
        ai.color = .black
        ai.startAnimating()
        ai.hidesWhenStopped = true
        return ai
    }()
    
    init() {
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupActivitySpinner()
        
        setupCollectionView()
        setupData()
    }
    
    fileprivate func setupActivitySpinner() {
        view.addSubview(activitySpinnerView)
        activitySpinnerView.fillSuperview()
    }
    
    fileprivate func setupData() {
        
        let dispatchGroup = DispatchGroup()
        
        var group1: AppGroup?
        var group2: AppGroup?
        var group3: AppGroup?
        
        dispatchGroup.enter()
        Network.shared.fetchNewAppsWeLove { (result) in
            dispatchGroup.leave()
            switch result {
            case .success(let appGroup):
                group1 = appGroup
            case .failure(let error):
                print("Error Setting Up Apps Controller Data", error.localizedDescription)
            }
        }
        
        dispatchGroup.enter()
        Network.shared.fetchTopGrossing { (result) in
            dispatchGroup.leave()
            switch result {
            case .success(let appGroup):
                group2 = appGroup
            case .failure(let error):
                print("Error Setting Up Apps Controller Data", error.localizedDescription)
            }
        }
        
        dispatchGroup.enter()
        Network.shared.fetchTopPaid { (result) in
            dispatchGroup.leave()
            switch result {
            case .success(let appGroup):
                group3 = appGroup
            case .failure(let error):
                print("Error Setting Up Apps Controller Data", error.localizedDescription)
            }
        }
        
        dispatchGroup.notify(queue: .main) {
            if let group = group1 {
                self.groups.append(group)
            }
            if let group = group2 {
                self.groups.append(group)
            }
            if let group = group3 {
                self.groups.append(group)
            }
            self.activitySpinnerView.stopAnimating()
            self.headerHeight = 350
            self.collectionView.reloadData()
        }
    }
    
    fileprivate func setupCollectionView() {
        collectionView.backgroundColor = .white
        collectionView.register(AppsGroupCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.register(AppsHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerId)
    }
}

extension AppController: UICollectionViewDelegateFlowLayout {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return groups.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! AppsGroupCell
        let group = groups[indexPath.item]
        cell.titleLabel.text = group.feed.title
        cell.horizontalCollectionView.appGroup = group
        cell.horizontalCollectionView.didSelectHandler = { [weak self] app in
            let redViewController = UIViewController()
            redViewController.view.backgroundColor = .red
            self?.navigationController?.pushViewController(redViewController, animated: true)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width, height: 350)
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as! AppsHeaderView
        return view
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return .init(width: view.frame.width, height: headerHeight)
    }
}
