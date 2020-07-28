//
//  NoResultsCell.swift
//  Picaboo
//
//  Created by Sebastien Menozzi on 28/07/2020.
//

import UIKit

final class NoResultsCell: UICollectionViewCell {
    
    let titleLabel = UILabel(text: "", font: UIFont.systemFont(ofSize: 26), numberOfLines: 0, color: .white)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(titleLabel)
        titleLabel.fillSuperview(padding: UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
