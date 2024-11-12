//
//  LabelExtension.swift
//  noRemoteCase
//
//  Created by Onur Karakuş on 7.11.2024.
//

import Foundation
import UIKit

extension UILabel {
    
    func setPriceText(_ price: Double) {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.locale = Locale(identifier: "tr_TR")
        let priceText = (formatter.string(from: NSNumber(value: price)) ?? "\(price)") + " TL"
        let attributedString = NSAttributedString(
            string: priceText,
            attributes: [
                .strikethroughStyle: NSUnderlineStyle.single.rawValue,
                .foregroundColor: UIColor.red
            ]
        )
        self.attributedText = attributedString
    }
}

extension Double {
    
    var asTL: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.locale = Locale(identifier: "tr_TR")
        
        if let formattedString = formatter.string(from: NSNumber(value: self)) {
            return "\(formattedString) TL"
        } else {
            return "\(self) TL"
        }
    }
}

