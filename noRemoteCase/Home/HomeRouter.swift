//
//  HomeRouter.swift
//  noRemoteCase
//
//  Created by Onur Karakuş on 6.11.2024.
//

import Foundation
import UIKit

typealias EntryPoint = UIViewController

protocol AnyRouter {
    var entry : EntryPoint? { get }
    static func start() -> AnyRouter
    func navigateToDetail(productID: Int)
}

class HomeRouter: AnyRouter {
    var entry: EntryPoint?
    weak var viewController: UIViewController?
    
    static func start() -> any AnyRouter {
        let router = HomeRouter()
        
        var view: AnyView = HomeViewController()
        var interactor: AnyInteractor = HomeInteractor()
        var presenter: AnyPresenter = HomePresenter()
        
        view.presenter = presenter
        interactor.presenter = presenter
        presenter.router = router
        presenter.view = view
        presenter.interactor = interactor
        
        router.entry = UINavigationController(rootViewController: view as! UIViewController)
        router.viewController = router.entry
        
        return router
    }
    
    func navigateToDetail(productID: Int) {
        guard let fromViewController = entry as? UINavigationController else { return }
        let detailRouter = DetailRouter.start(productID: productID)
        if let detailVC = detailRouter.entry {
            fromViewController.pushViewController(detailVC, animated: true)
        }
    }

    
}

