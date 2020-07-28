//
//  ImageCache.swift
//  Picaboo
//
//  Created by Sebastien Menozzi on 28/07/2020.
//

import Foundation
import UIKit.UIImage

public final class ImageCache {

    private lazy var imageCache: NSCache<NSURL, AnyObject> = {
        let cache = NSCache<NSURL, AnyObject>()
        return cache
    }()
    
    private let lock = NSLock()

    public func getImage(for url: URL) -> UIImage? {
        lock.lock()
        defer {
            lock.unlock()
        }
        
        return imageCache.object(forKey: url as NSURL) as? UIImage
    }

    public func insertImage(_ image: UIImage?, for url: URL) {
        lock.lock()
        defer {
            lock.unlock()
        }
        
        guard let image = image else { return removeImage(for: url) }
        
        imageCache.setObject(image as AnyObject, forKey: url as NSURL, cost: 1)
    }

    public func removeImage(for url: URL) {
        lock.lock()
        defer {
            lock.unlock()
        }
        
        imageCache.removeObject(forKey: url as NSURL)
    }
}
