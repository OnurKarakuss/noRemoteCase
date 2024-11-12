//
//  DetailViewComponents.swift
//  noRemoteCase
//
//  Created by Onur Karakuş on 12.11.2024.
//

import Foundation
import UIKit

class DetailViewComponents: UIView {
    
    let detailCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.isPagingEnabled = true
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    let detailTitle: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let sellerName: UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        label.font = UIFont.systemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .gray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let price: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let discountPrice: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    private func setupUI() {
        addSubview(detailCollectionView)
        addSubview(detailTitle)
        addSubview(sellerName)
        addSubview(separatorView)
        addSubview(price)
        addSubview(discountPrice)
        
        NSLayoutConstraint.activate([
            detailCollectionView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            detailCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            detailCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            detailCollectionView.heightAnchor.constraint(equalToConstant: 300),
            
            detailTitle.topAnchor.constraint(equalTo: detailCollectionView.bottomAnchor, constant: 12),
            detailTitle.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            detailTitle.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            
            sellerName.topAnchor.constraint(equalTo: detailTitle.bottomAnchor, constant: 8),
            sellerName.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            sellerName.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            
            separatorView.topAnchor.constraint(equalTo: sellerName.bottomAnchor, constant: 8),
            separatorView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            separatorView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            separatorView.heightAnchor.constraint(equalToConstant: 1),
            
            price.topAnchor.constraint(equalTo: separatorView.bottomAnchor, constant: 12),
            price.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            price.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            
            discountPrice.topAnchor.constraint(equalTo: price.bottomAnchor, constant: 8),
            discountPrice.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            discountPrice.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12)
        ])
    }
    
    func configure(with detailProduct: DetailResponse) {
        detailTitle.text = detailProduct.title
        sellerName.text = detailProduct.sellerName
        price.setPriceText(detailProduct.price)
        discountPrice.text = "\(detailProduct.instantDiscountPrice?.asTL ?? "")"
    }
}
