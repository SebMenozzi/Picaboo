//
//  PhotoViewModel.swift
//  Picaboo
//
//  Created by Sebastien Menozzi on 28/07/2020.
//

import Foundation
import IGListKit

final class PhotoViewModel: ListDiffable {
    
    let url: String
    let color: String
    
    init(url: String, color: String) {
        self.url = url
        self.color = color
    }
    
    func diffIdentifier() -> NSObjectProtocol {
        return "photo" as NSObjectProtocol
    }
    
    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        guard let object = object as? PhotoViewModel else { return false }
        
        return url == object.url
    }
    
}
