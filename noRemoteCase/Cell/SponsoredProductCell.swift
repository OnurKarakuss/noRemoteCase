//
//  SponsoredProductCell.swift
//  noRemoteCase
//
//  Created by Onur Karakuş on 6.11.2024.
//

import UIKit
import Kingfisher

class SponsoredProductCell: UICollectionViewCell {

    @IBOutlet weak var sponsoredCollectionView: UICollectionView!
    private var products: [SponsoredProduct] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        sponsoredCollectionView.register(UINib(nibName: "SingleSponsoredProductCell", bundle: nil), forCellWithReuseIdentifier: "SingleSponsoredProductCell")
        sponsoredCollectionView.translatesAutoresizingMaskIntoConstraints = false
        sponsoredCollectionView.dataSource = self
        sponsoredCollectionView.delegate = self
        contentView.addSubview(sponsoredCollectionView)
    }
    
    func configure(product: [SponsoredProduct]) {
        self.products = product
        sponsoredCollectionView.reloadData()
    }
    
}

extension SponsoredProductCell: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = sponsoredCollectionView.dequeueReusableCell(withReuseIdentifier: "SingleSponsoredProductCell", for: indexPath) as! SingleSponsoredProductCell
        cell.configure(product: products[indexPath.row])
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width , height: 250)
    }
    
}
