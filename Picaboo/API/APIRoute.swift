//
//  APIRoute.swift
//  Picaboo
//
//  Created by Sebastien Menozzi on 28/07/2020.
//

import Alamofire

public enum APIRoute {
    
    case fetchPhotos(page: Int = 0)
    
    public var method: HTTPMethod {
        switch self {
            case .fetchPhotos:
                return .get
        }
    }
    
    public var path: String {
        switch self {
            case .fetchPhotos(let page):
                return "/photos?client_id=\(Constants.API_KEY)&per_page=\(Constants.NB_PER_PAGE)&page=\(page)"
        }
    }
    
    public var parameters: Parameters? {
        switch self {
            case .fetchPhotos:
                return nil
        }
    }
    
    public var headers: HTTPHeaders {
        switch self {
            case .fetchPhotos:
                return [ "Accept": "application/json" ]
        }
    }
    
}
