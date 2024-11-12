//
//  DetailView.swift
//  noRemoteCase
//
//  Created by Onur Karakuş on 8.11.2024.
//

import Foundation
import UIKit

protocol DetailView: AnyObject {
    var presenter: DetailPresenterProtocol? { get set }
    func update(with response: DetailResponse)
    func update(with error: String)
}

class DetailViewController: UIViewController, DetailView{
    
    var presenter: (any DetailPresenterProtocol)?
    var detailProduct: DetailResponse?
    private let detailViewComponents = DetailViewComponents()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        presenter?.viewDidLoad()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        view.addSubview(detailViewComponents)
        detailViewComponents.detailCollectionView.dataSource = self
        detailViewComponents.detailCollectionView.delegate = self
        detailViewComponents.detailCollectionView.register(UINib(nibName: Strings.CollectionViewCells.detailCollectionViewCell, bundle: nil), forCellWithReuseIdentifier: Strings.CollectionViewCells.detailCollectionViewCell)
        detailViewComponents.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            detailViewComponents.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            detailViewComponents.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            detailViewComponents.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            detailViewComponents.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
       }
    
    func update(with response: DetailResponse) {
        DispatchQueue.main.async {
            self.detailProduct = response
            self.detailViewComponents.configure(with: response)
            self.detailViewComponents.detailCollectionView.reloadData()
        }
    }
    
    func update(with error: String) {
        print(error)
    }
    
}
extension DetailViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.detailProduct?.images.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Strings.CollectionViewCells.detailCollectionViewCell, for: indexPath) as! DetailCollectionViewCell
        if let imageURL = detailProduct?.images[indexPath.row] {
            cell.configure(image: imageURL)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
}
