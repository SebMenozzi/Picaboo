//
//  PhotoCell.swift
//  Picaboo
//
//  Created by Sebastien Menozzi on 28/07/2020.
//

import UIKit
import IGListKit

protocol PhotoCellDelegate: class {
    func didTapPhoto(photoImageView: UIImageView)
}

final class PhotoCell: UICollectionViewCell {
    
    weak var delegate: PhotoCellDelegate? = nil
    
    let padding: CGFloat = 5
    
    lazy var photoImageView: UIImageView = {
        let imageView = UIImageView(cornerRadius: 20)
        imageView.backgroundColor = .black
        imageView.contentMode = .scaleAspectFill
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleImage)))
        return imageView
    }()
    
    @objc func handleImage(sender: UITapGestureRecognizer) {
        delegate?.didTapPhoto(photoImageView: photoImageView)
    }
    
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
