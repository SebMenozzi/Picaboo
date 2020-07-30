//
//  Photos.swift
//  Picaboo
//
//  Created by Sebastien Menozzi on 27/07/2020.
//

import Foundation

class PhotoUrls: Codable {
    let small: String
}

class Photo: Codable {
    let color: String
    let urls: PhotoUrls
}
