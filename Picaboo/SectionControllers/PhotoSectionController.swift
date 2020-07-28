//
//  PhotosSectionController.swift
//  Picaboo
//
//  Created by Sebastien Menozzi on 28/07/2020.
//

import UIKit
import IGListKit

protocol PhotosSectionControllerDelegate: class {
    func didTapPhoto(photoView: UIView)
}

final class PhotoSectionController: ListBindingSectionController<PhotoWithID>, ListBindingSectionControllerDataSource, ListDisplayDelegate {
    
    weak var delegate: PhotosSectionControllerDelegate?
    
    override init() {
        super.init()
        
        dataSource = self
        displayDelegate = self
    }
    
    // MARK: ListBindingSectionControllerDataSource
    
    func sectionController(_ sectionController: ListBindingSectionController<ListDiffable>, viewModelsFor object: Any) -> [ListDiffable] {
        guard let object = object as? PhotoWithID else { fatalError() }
        
        var viewModels: [ListDiffable] = []
        
        viewModels.append(PhotoViewModel(
            url: object.photo.urls.small,
            color: object.photo.color
        ))
        
        return viewModels
    }
    
    func sectionController(_ sectionController: ListBindingSectionController<ListDiffable>, cellForViewModel viewModel: Any, at index: Int) -> UICollectionViewCell & ListBindable {
        
        guard let cell = collectionContext?.dequeueReusableCell(of: PhotoCell.self, for: self, at: index) as? UICollectionViewCell & ListBindable else { fatalError() }
        
        return cell
    }
    
    func sectionController(_ sectionController: ListBindingSectionController<ListDiffable>, sizeForViewModel viewModel: Any, at index: Int) -> CGSize {
        if viewModel is PhotoViewModel {
            let width = collectionContext?.containerSize.width ?? 0
            let itemSize = floor(width / 2)

            return CGSize(width: itemSize, height: itemSize)
        }
        
        return .zero
    }
    
    // MARK: ListDisplayDelegate
    
    func listAdapter(_ listAdapter: ListAdapter, willDisplay sectionController: ListSectionController) {}
    
    func listAdapter(_ listAdapter: ListAdapter,
                     willDisplay sectionController: ListSectionController,
                     cell: UICollectionViewCell,
                     at index: Int) {
        // cool animation :)
        
        cell.contentView.alpha = 0
        
        UIView.animateKeyframes(withDuration: 0.3, delay: 0, options: .allowUserInteraction, animations: {
            cell.contentView.alpha = 1.0
        }, completion: nil )
    }
    
    func listAdapter(_ listAdapter: ListAdapter, didEndDisplaying sectionController: ListSectionController) {}
    
    func listAdapter(_ listAdapter: ListAdapter,
                     didEndDisplaying sectionController: ListSectionController,
                     cell: UICollectionViewCell,
                     at index: Int) {}
    
}
