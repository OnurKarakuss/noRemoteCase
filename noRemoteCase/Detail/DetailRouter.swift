//
//  DetailRouter.swift
//  noRemoteCase
//
//  Created by Onur Karakuş on 8.11.2024.
//

import Foundation
import UIKit

protocol DetailRouterProtocol {
    var entry : EntryPoint? { get }
    static func start(productID: Int) -> DetailRouter
}

class DetailRouter: DetailRouterProtocol {

    var entry: EntryPoint?
    
    static func start(productID: Int) -> DetailRouter {
        let router = DetailRouter()
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let viewController = storyboard.instantiateViewController(withIdentifier: Strings.DetailView.detailViewController) as? DetailViewController else {
            fatalError(Strings.Error.controllerError)
        }
        
        let view: DetailView = viewController
        let presenter = DetailPresenter()
        let interactor = DetailInteractor()
        
        view.presenter = presenter
        interactor.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        
        router.entry = viewController
        presenter.productId = productID
        presenter.viewDidLoad()
        
        return router
    }
}

