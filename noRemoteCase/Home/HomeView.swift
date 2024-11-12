//
//  HomeView.swift
//  noRemoteCase
//
//  Created by Onur Karakuş on 6.11.2024.
//
import UIKit

protocol AnyView {
    var presenter: AnyPresenter? { get set }
    func update(with response: ProductResponse)
    func update(with error: String)
}

class HomeViewController: UIViewController, AnyView{
    var presenter: (any AnyPresenter)?
    var products: [Product] = []
    var sponsoredProducts: [SponsoredProduct] = []
    var nextPage: String?
    var isFetching = false
    let homeCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor(named: "backgroundGray100")
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
    }
    
    func setupCollectionView() {
        view.addSubview(homeCollectionView)
        homeCollectionView.translatesAutoresizingMaskIntoConstraints = false
        homeCollectionView.delegate = self
        homeCollectionView.dataSource = self
        homeCollectionView.register(UINib(nibName: Strings.CollectionViewCells.sponsoredProductCell, bundle: nil), forCellWithReuseIdentifier: Strings.CollectionViewCells.sponsoredProductCell)
        homeCollectionView.register(UINib(nibName: Strings.CollectionViewCells.productCell, bundle: nil), forCellWithReuseIdentifier: Strings.CollectionViewCells.productCell)
        homeCollectionView.frame = view.bounds
    }
    
    func update(with response: ProductResponse) {
        self.products.append(contentsOf: response.products)
        self.sponsoredProducts = response.sponsoredProducts
        self.nextPage = response.nextPage
        DispatchQueue.main.async {
            self.homeCollectionView.reloadData()
        }
    }
    
    func update(with error: String) {
        print(error)
    }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return section == 0 ? 1 : products.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Strings.CollectionViewCells.sponsoredProductCell, for: indexPath) as! SponsoredProductCell
            cell.configure(product: sponsoredProducts)
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Strings.CollectionViewCells.productCell, for: indexPath) as! ProductCell
            cell.configure(product: products[indexPath.row])
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 0 {
            return CGSize(width: collectionView.frame.width, height: 250)
        } else {
            let width = (collectionView.frame.width - 2) / 2
            return CGSize(width: width, height: 350)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedProductID: Int
        if indexPath.section == 0 {
            selectedProductID = sponsoredProducts[indexPath.row].id
        } else {
            selectedProductID = products[indexPath.row].id
        }
        presenter?.navigateToDetail(productID: selectedProductID)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        if section == 0 {
            return .init(top: 0, left: 0, bottom: 6, right: 0)
        } else {
            return .zero
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height
        
        if offsetY > contentHeight - height * 1.5, !isFetching, nextPage != nil {
            isFetching = true
            if let page = nextPage {
                presenter?.fetchNextPage(page: page)
            }
        }
    }
}
