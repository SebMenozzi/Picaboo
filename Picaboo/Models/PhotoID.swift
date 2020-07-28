//
//  PhotoID.swift
//  Picaboo
//
//  Created by Sebastien Menozzi on 28/07/2020.
//

import Foundation
import IGListKit

/*
 PhotoID is just an object to add an id to a Photo object,
 because IGListKit crashes if there are 2 equal objects,
 whereas we want to be able to display duplicates of a photo.
 This is why we create a random id that we use as a
 unique idenfier.
 */
class PhotoWithID: NSObject {
    let id: UUID
    let photo: Photo
    
    init(id: UUID, photo: Photo) {
        self.id = id
        self.photo = photo
    }
}

extension PhotoWithID: ListDiffable {
    
    func diffIdentifier () -> NSObjectProtocol {
        return id as NSObjectProtocol
    }
    
    func isEqual (toDiffableObject object: ListDiffable?) -> Bool {
        guard let photoId = object as? PhotoWithID else { return false }
        
        return id == photoId.id
    }
    
}
