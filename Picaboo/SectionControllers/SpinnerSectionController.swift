//
//  SpinnerSectionController.swift
//  Picaboo
//
//  Created by Sebastien Menozzi on 28/07/2020.
//

import IGListKit
import UIKit

func spinnerSectionController() -> ListSingleSectionController {
    let configureBlock = { (item: Any, cell: UICollectionViewCell) in
        guard let cell = cell as? SpinnerCell else { return }
        
        cell.activityIndicator.startAnimating()
    }
    
    let sizeBlock = { (item: Any, context: ListCollectionContext?) -> CGSize in
        guard let context = context else { return .zero }
        
        return CGSize(width: context.containerSize.width, height: 100)
    }
    
    return ListSingleSectionController(
        cellClass: SpinnerCell.self,
        configureBlock: configureBlock,
        sizeBlock: sizeBlock
    )
}
