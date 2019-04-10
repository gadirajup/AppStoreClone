//
//  SearchController.swift
//  AppStoreClone
//
//  Created by Prudhvi Gadiraju on 4/8/19.
//  Copyright © 2019 Prudhvi Gadiraju. All rights reserved.
//

import UIKit

class SearchController: UICollectionViewController {
    
    // Properties
    fileprivate var appResults = [SearchResult]()
    fileprivate let cellId = "cell"
    fileprivate var timer: Timer?
    
    // UI Elements
    fileprivate let searchController = UISearchController(searchResultsController: nil)
    fileprivate let enterSearchTermLabel: UILabel = {
        let label = UILabel()
        label.text = "Wanna search for something?"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 20)
        return label
    }()
    
    // Init
    
    init() {
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollectionView()
        setupSearchBar()
        setupLabel()
        //setupData()
    }
    
    // Setup
    
    fileprivate func setupCollectionView() {
        collectionView.backgroundColor = .white
        collectionView.register(SearchCell.self, forCellWithReuseIdentifier: cellId)
    }
    
    fileprivate func setupSearchBar() {
        definesPresentationContext = true
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self
    }
    
    fileprivate func setupLabel() {
        view.addSubview(enterSearchTermLabel)
        enterSearchTermLabel.fillSuperview()
    }
    
    fileprivate func setupData() {
        fetchData(withSearchTerm: "instagram")
    }
    
    // Logic
    
    fileprivate func fetchData(withSearchTerm searchTerm: String) {
        Network.shared.fetchAppSearchData(searchTerm: searchTerm) { [weak self] (result) in
            switch result {
            case .failure(let error):
                print("Failed to setup Data", error.localizedDescription)
            case .success(let results):
                self?.appResults = results
                self?.collectionView.reloadData()
            }
        }
    }
}

extension SearchController: UICollectionViewDelegateFlowLayout {
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        enterSearchTermLabel.isHidden = appResults.count != 0 ? true : false
        return appResults.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! SearchCell
        let appResult = appResults[indexPath.item]
        cell.appResult = appResult
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width, height: 350)
    }
}

extension SearchController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 0.25, repeats: false) { (_) in
            self.fetchData(withSearchTerm: searchText)
        }
    }
}
