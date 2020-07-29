//
//  ImageLoader.swift
//  Picaboo
//
//  Created by Sebastien Menozzi on 28/07/2020.
//

import Foundation
import UIKit

public final class ImageLoader {
    
    public static let shared = ImageLoader()

    private let cache: ImageCache = ImageCache()
    
    private var imageRequests = [UUID: URLSessionDataTask]()

    public func loadImage(from url: URL, completion: @escaping (Result<UIImage, Error>) -> Void) -> UUID? {
        if let cachedImage = cache.getImage(for: url) {
            completion(.success(cachedImage))
            return nil
        }
        
        let taskId = UUID()
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            if let data = data, let image = UIImage(data: data) {
                self.cache.insertImage(image, for: url)
                completion(.success(image))
                return
            }
            
            if let error = error {
                completion(.failure(error))
                return
            }
        }
        
        task.resume()

        imageRequests[taskId] = task
        
        return taskId
    }
    
    func cancelLoad(_ taskId: UUID) {
        imageRequests[taskId]?.cancel()
        imageRequests.removeValue(forKey: taskId)
    }
    
}
