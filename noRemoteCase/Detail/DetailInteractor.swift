//
//  DetailInteractor.swift
//  noRemoteCase
//
//  Created by Onur Karakuş on 8.11.2024.
//

import Foundation

protocol DetailInteractorProtocol {
    var presenter: DetailPresenterProtocol? { get set }
    func fetchDetail(for productID: Int)
}
class DetailInteractor: DetailInteractorProtocol {
    
    var presenter: (any DetailPresenterProtocol)?
    
    func fetchDetail(for productID: Int) {
        guard let url = URL(string: Strings.DetailView.detailUrl + "\(productID)") else { return }
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let data = data, error == nil else { return }
            do {
                let entities = try JSONDecoder().decode(DetailResponse.self, from: data)
                self?.presenter?.didFetchDetail(with: .success(entities))
            } catch {
                self?.presenter?.didFetchDetail(with: .failure(error))
            }
        }
        task.resume()
    }
}
