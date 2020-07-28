//
//  SpinnerCell.swift
//  Picaboo
//
//  Created by Sebastien Menozzi on 28/07/2020.
//

import UIKit

final class SpinnerCell: UICollectionViewCell {

    lazy var activityIndicator: UIActivityIndicatorView = {
        let ai = UIActivityIndicatorView(style: .medium)
        self.contentView.addSubview(ai)
        return ai
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let bounds = contentView.bounds
        activityIndicator.center = CGPoint(x: bounds.midX, y: bounds.midY)
    }
    
}
