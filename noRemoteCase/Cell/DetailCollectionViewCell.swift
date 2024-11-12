//
//  DetailCollectionViewCell.swift
//  noRemoteCase
//
//  Created by Onur Karakuş on 10.11.2024.
//

import UIKit
import Kingfisher

class DetailCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var detailImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func configure(image: String) {
        guard let imageUrl = URL(string: image) else { return }
        detailImage.kf.setImage(with: imageUrl)
    }

}
