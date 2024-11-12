//
//  HomeInteractor.swift
//  noRemoteCase
//
//  Created by Onur Karakuş on 6.11.2024.
//

import Foundation

protocol AnyInteractor {
    var presenter: AnyPresenter? { get set }
    func getResponse(page: String)
}

class HomeInteractor: AnyInteractor {
    
    var presenter: (any AnyPresenter)?
    
    func getResponse(page: String) {
        guard let url = URL(string: Strings.HomeView.homeUrl + "\(page)") else { return }
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let data = data, error == nil else { return }
            do {
                let entities = try JSONDecoder().decode(ProductResponse.self, from: data)
                self?.presenter?.interactorDidFetchProducts(with: .success(entities))
            } catch {
                self?.presenter?.interactorDidFetchProducts(with: .failure(error))
            }
        }
        task.resume()
    }
}
