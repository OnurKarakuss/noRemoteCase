//
//  SingleSponsoredProductCell.swift
//  noRemoteCase
//
//  Created by Onur Karakuş on 7.11.2024.
//

import UIKit

class SingleSponsoredProductCell: UICollectionViewCell {

    @IBOutlet weak var rate: UIButton!
    @IBOutlet weak var discountPrice: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var image: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(product: SponsoredProduct) {
        rate.setTitle("%\(String(product.rate ?? 0.0))", for: .normal)
        title.text = product.title
        price.setPriceText(product.price)
        discountPrice.text = "\(product.instantDiscountPrice.asTL)"
        guard let imageUrl = URL(string: product.image) else { return }
        image.kf.setImage(with: imageUrl)
    }
}
