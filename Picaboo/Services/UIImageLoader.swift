//
//  UIImageLoader.swift
//  Picaboo
//
//  Created by Sebastien Menozzi on 28/07/2020.
//

import UIKit

public final class UIImageLoader {
    
    public static let shared = UIImageLoader()

    private var taskIdsDictionary = [UIImageView: UUID]()
    
    private func showImage(for imageView: UIImageView, image: UIImage?) {
        self.taskIdsDictionary.removeValue(forKey: imageView)
        
        DispatchQueue.main.async {
            imageView.image = image
        }
    }

    func load(_ url: URL, for imageView: UIImageView) {
        let taskId = ImageLoader.shared.loadImage(from: url) { result in
            do {
                let image = try result.get()
                
                self.showImage(for: imageView, image: image)
            } catch {
                
            }
        }
        
        if let taskId = taskId {
            taskIdsDictionary[imageView] = taskId
        }
    }

    func cancel(for imageView: UIImageView) {
        if let uuid = taskIdsDictionary[imageView] {
            ImageLoader.shared.cancelLoad(uuid)
            
            taskIdsDictionary.removeValue(forKey: imageView)
        }
    }
    
}
