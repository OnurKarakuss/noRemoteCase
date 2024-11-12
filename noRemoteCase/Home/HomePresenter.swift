//
//  HomePresenter.swift
//  noRemoteCase
//
//  Created by Onur Karakuş on 6.11.2024.
//

import Foundation

protocol AnyPresenter {
    var router: AnyRouter? { get set }
    var interactor: AnyInteractor? { get set }
    var view: AnyView? { get set }
    
    func interactorDidFetchProducts(with result: Result<ProductResponse, Error>)
    func navigateToDetail(productID: Int)
    func fetchNextPage(page: String)
}

class HomePresenter: AnyPresenter {
    var router: (any AnyRouter)?
    
    var interactor: (any AnyInteractor)? {
        didSet {
            interactor?.getResponse(page: "1")
        }
    }
    
    var view: (any AnyView)?
    
    func interactorDidFetchProducts(with result: Result<ProductResponse, any Error>) {
        switch result {
        case .success(let product):
            view?.update(with: product)
        case .failure:
            view?.update(with: Strings.Error.error)
        }
    }
    
    func fetchNextPage(page: String) {
        interactor?.getResponse(page: page)
    }
    
    func navigateToDetail(productID: Int) {
        router?.navigateToDetail(productID: productID)
    }
    
    
}

