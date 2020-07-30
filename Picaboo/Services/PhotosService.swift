//
//  PhotosService.swift
//  Picaboo
//
//  Created by Sebastien Menozzi on 28/07/2020.
//

import UIKit

public final class PhotosService {
    
    private var currentPage = 1
    
    private var hasNext: Bool = true
    
    private var isPaginating = false
    
    private var photos = [PhotoWithID]()
    
    func getPhotos() -> [PhotoWithID] {
        return photos
    }
    
    func getHasNext() -> Bool {
        return hasNext
    }
    
    func refresh(completion: (() -> Void)? = nil) {
        currentPage = 1
        photos = []
        hasNext = true
        fetch { _ in
            completion?()
        }
    }
    
    func fetch(completion:  @escaping (Bool) -> Void) {
        if !isPaginating {
            isPaginating = true
            
            if !hasNext {
                isPaginating = false
                completion(true)
                return
            }
            
            let route: APIRoute = APIRoute.fetchPhotos(page: currentPage)
            
            // perform network task on a background queue
            DispatchQueue.global(qos: .background).async {
                APIManager.shared.fetchJSONData(route: route, completion: { (result: APIManager.Result<[Photo]>) in
                    switch result {
                        case .success(let object):
                            // transform each Photo object to a PhotoWithID object
                            for photo in object {
                                let uuid = UUID()
                                let photoID = PhotoWithID(id: uuid, photo: photo)
                                self.photos.append(photoID)
                            }
                            
                            self.currentPage += 1
                            
                            self.hasNext = object.count == Constants.NB_PER_PAGE
                            
                            self.isPaginating = false
                            
                            completion(true)
                        case .errorNetwork( _), .errorDecoding( _):
                            completion(false)
                    }
                })
            }
        }
    }
}
