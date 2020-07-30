//
//  PhotoCell.swift
//  Picaboo
//
//  Created by Sebastien Menozzi on 28/07/2020.
//

import UIKit
import IGListKit

final class PhotoCell: UICollectionViewCell {
    
    let padding: CGFloat = 5
    
    lazy var photoImageView: UIImageView = {
        let imageView = UIImageView(cornerRadius: 20)
        imageView.backgroundColor = .black
        imageView.contentMode = .scaleAspectFill
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.addSubview(photoImageView)
        photoImageView.fillSuperview(padding: UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding))
    }
    
    override public func prepareForReuse() {
        super.prepareForReuse()
        
        photoImageView.image = nil
        photoImageView.cancelImageLoad()
    }
    
}

extension PhotoCell: ListBindable {
    
    func bindViewModel(_ viewModel: Any) {
        guard let photoViewModel = viewModel as? PhotoViewModel else { return }
        
        photoImageView.backgroundColor = UIColor(hex: photoViewModel.color) ?? .red
        
        let url = URL(string: photoViewModel.url)!
        
        photoImageView.loadImage(at: url)
    }
    
}
