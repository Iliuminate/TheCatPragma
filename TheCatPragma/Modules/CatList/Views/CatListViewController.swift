//
//  CatListViewController.swift
//  TheCatPragma
//
//  Created by CarlosDz on 9/06/23.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the 🐍 VIPER generator
//

import UIKit

final class CatListViewController: UIViewController {

    // MARK: - @IBOutlets -
    @IBOutlet weak var mainCollecionView: UICollectionView!
    
    // MARK: - Public properties -
    var presenter: CatListPresenterInterface!

    // MARK: - Lifecycle -
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpCollectionView()
        presenter.getCats()
    }
    
    func setUpView() {
        navigationController?.title = "Catbreeds"
    }
    
    func setUpCollectionView() {
        mainCollecionView.register(UINib(nibName: "CatCell", bundle: nil), forCellWithReuseIdentifier: "CatCell")
        mainCollecionView.dataSource = self
        mainCollecionView.delegate = self
    }
}

// MARK: - CatListViewInterface -
extension CatListViewController: CatListViewInterface {
    
    func reloadData() {
        mainCollecionView.reloadData()
    }
}

// MARK: - UICollectionViewDelegateFlowLayout  -
extension CatListViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = UIScreen.main.bounds.width
        return CGSize(width: width - 24, height: 308.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 4, left: 12, bottom: 12, right: 12)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 8.0
    }
}

// MARK: - UICollectionViewDelegate  -
extension CatListViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter.showDetail(index: indexPath)
    }
}

// MARK: - UICollectionViewDelegate  -
extension CatListViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.cats.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CatCell", for: indexPath) as! CatCell
        cell.configure(with: presenter.getCatModel(index: indexPath))
        return cell
    }
    
}

