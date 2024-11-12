//
//  HomeEntity.swift
//  noRemoteCase
//
//  Created by Onur Karakuş on 6.11.2024.
//

import Foundation
//Model

struct User: Codable {
    let name: String
}
// Main Response Model
struct ProductResponse: Codable {
    let page: String
    let nextPage: String
    let publishedAt: String?
    let sponsoredProducts: [SponsoredProduct]
    let products: [Product]
}

// Sponsored Product Model
struct SponsoredProduct: Codable {
    let id: Int
    let title: String
    let image: String
    let price: Double
    let instantDiscountPrice: Double
    let rate: Double?
}

// Product Model
struct Product: Codable {
    let id: Int
    let title: String
    let image: String
    let price: Double
    let instantDiscountPrice: Double?
    let rate: Double?
    let sellerName: String
}


