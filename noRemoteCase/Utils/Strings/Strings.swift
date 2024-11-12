//
//  Strings.swift
//  noRemoteCase
//
//  Created by Onur Karakuş on 12.11.2024.
//

import Foundation

struct Strings {
    
    struct HomeView {
        static let homeUrl = "https://private-d3ae2-n11case.apiary-mock.com/listing/"
    }
    
    struct DetailView {
        static let detailUrl = "https://private-d3ae2-n11case.apiary-mock.com/product?productId="
        static let detailViewController = "DetailViewController"
    }
    
    struct CollectionViewCells {
        static let productCell = "ProductCell"
        static let sponsoredProductCell = "SponsoredProductCell"
        static let singleSponsoredProductCell = "SingleSponsoredProductCell"
        static let detailCollectionViewCell = "DetailCollectionViewCell"
    }
    
    struct Error {
        static let error = "Something went wrong"
        static let controllerError = "DetailViewController could not be instantiated"
    }
}
