//
//  DetailPresenter.swift
//  noRemoteCase
//
//  Created by Onur Karakuş on 8.11.2024.
//

import Foundation

protocol DetailPresenterProtocol{
    var router: DetailRouterProtocol? { get set }
    var interactor: DetailInteractorProtocol? { get set }
    var view: DetailView? { get set }
    func didFetchDetail(with result: Result<DetailResponse, Error>)
    func viewDidLoad()
    var productId: Int? {get set}
}

class DetailPresenter: DetailPresenterProtocol {
    var view: (any DetailView)?
    var interactor: DetailInteractorProtocol?
    var router: DetailRouterProtocol?
    var productId: Int?
    func didFetchDetail(with result: Result<DetailResponse, Error>) {
        switch result {
        case .success(let product):
            view?.update(with: product)
        case .failure:
            view?.update(with: Strings.Error.error)
        }
    }
    
    func viewDidLoad() {
        interactor?.fetchDetail(for: productId ?? 1)
    }
}
