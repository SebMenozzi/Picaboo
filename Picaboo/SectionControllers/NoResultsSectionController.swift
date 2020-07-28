//
//  NoResultsSectionController.swift
//  Picaboo
//
//  Created by Sebastien Menozzi on 28/07/2020.
//

import IGListKit
import UIKit

func noResultsSectionController(text: String? = NSLocalizedString("No Results 🤔", comment: "")) -> ListSingleSectionController {
    
    let configureBlock = { (item: Any, cell: UICollectionViewCell) in
        guard let cell = cell as? NoResultsCell else { return }
        
        cell.titleLabel.text = text
        cell.titleLabel.textAlignment = .center
    }
    
    let sizeBlock = { (item: Any, context: ListCollectionContext?) -> CGSize in
        guard let context = context else { return .zero }
        
        let padding: CGFloat = 20
        let width = context.containerSize.width - (padding * 2)
        let height = UIScreen.main.bounds.height / 5
        
        return CGSize(width: width, height: height)
    }
    
    return ListSingleSectionController(
        cellClass: NoResultsCell.self,
        configureBlock: configureBlock,
        sizeBlock: sizeBlock
    )
    
}
