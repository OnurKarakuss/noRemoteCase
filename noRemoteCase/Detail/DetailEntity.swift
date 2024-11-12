//
//  DetailEntity.swift
//  noRemoteCase
//
//  Created by Onur Karakuş on 8.11.2024.
//

import Foundation

struct DetailResponse: Codable {
    let title: String
    let description: String
    let images: [String]
    let price: Double
    let instantDiscountPrice: Double?
    let rate: Double
    let sellerName: String
}
