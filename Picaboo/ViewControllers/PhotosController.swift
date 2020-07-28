//
//  ViewController.swift
//  Picaboo
//
//  Created by Sebastien Menozzi on 27/07/2020.
//

import UIKit
import IGListKit

class PhotosController: UIViewController {
    
    var isLoading = false
    var isRefreshing = false
    let spinToken = "spinner"
    let noPhotosToken = "noPhotos"
    
    let photosService = PhotosService()
    
    let layout: ListCollectionViewLayout  = {
        let layout = ListCollectionViewLayout(stickyHeaders: false, scrollDirection: .vertical, topContentInset: 0, stretchToEdge: true)
        return layout
    }()
    
    lazy var collectionView: UICollectionView = {
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor(hex: "#150f41")
        cv.alwaysBounceVertical = true
        return cv
    }()
    
    lazy var adapter: ListAdapter =  {
        let updater = ListAdapterUpdater()
        let adapter = ListAdapter(updater: updater, viewController: self, workingRangeSize: 0)
        adapter.collectionView = collectionView
        adapter.dataSource = self
        adapter.scrollViewDelegate = self
        return adapter
    }()
    
    private let refreshControl = UIRefreshControl()
    
    private func setupCollectioView() {
        view.addSubview(collectionView)
        collectionView.fillSuperview(padding: UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5))
    }
    
    private func setupRefreshControl() {
        collectionView.addSubview(refreshControl)
        refreshControl.addTarget(self, action: #selector(refreshPhotos(_:)), for: .valueChanged)
    }
    
    @objc private func refreshPhotos(_ sender: Any) {
        isRefreshing = true
        photosService.refresh {
            DispatchQueue.main.async {
                self.refreshControl.endRefreshing()
                self.isRefreshing = false
                
                self.adapter.performUpdates(animated: true)
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(hex: "#150f41")
        
        setupCollectioView()
        
        setupRefreshControl()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        print("Fetch Photos")
        
        self.updateLoadingIndicatorUI(isLoading: true)
        
        photosService.fetch { _ in
            self.updateLoadingIndicatorUI(isLoading: false)
        }
    }
    
    private func updateLoadingIndicatorUI(isLoading: Bool = false) {
        DispatchQueue.main.async {
            self.isLoading = isLoading
            self.adapter.performUpdates(animated: true)
        }
    }
    
    private func loadMore() {
        if !isRefreshing && !isLoading && photosService.getHasNext() {
            self.updateLoadingIndicatorUI(isLoading: true)
            
            photosService.fetch { _ in
                self.updateLoadingIndicatorUI(isLoading: false)
            }
        }
    }
    
}

extension PhotosController: ListAdapterDataSource {
    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        var items: [ListDiffable] = photosService.getPhotos()
        
        if isLoading && photosService.getHasNext() {
            items.append(spinToken as ListDiffable)
        }
        
        if photosService.getPhotos().isEmpty && !photosService.getHasNext() {
            items.append(noPhotosToken as ListDiffable)
        }
        
        return items
    }
    
    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any)-> ListSectionController {
        if let obj = object as? String, obj == spinToken {
            return spinnerSectionController()
        } else if let obj = object as? String, obj == noPhotosToken {
            return noResultsSectionController(text: NSLocalizedString("No Photos 😑", comment: ""))
        } else { // PhotoWithID model otherwise
            return PhotoSectionController()
        }
    }
    
    func emptyView(for listAdapter: ListAdapter) -> UIView? {
        return nil
    }
    
}

extension PhotosController: UIScrollViewDelegate {
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView,
                                    withVelocity velocity: CGPoint,
                                    targetContentOffset: UnsafeMutablePointer <CGPoint>) {
        let distance = scrollView.contentSize.height - (targetContentOffset.pointee.y + scrollView.bounds.height)
        
        if distance < 200 {
            print("Load more...")
            
            self.loadMore()
        }
    }
    
}
