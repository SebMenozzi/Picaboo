//
//  APIManager.swift
//  Picaboo
//
//  Created by Sebastien Menozzi on 28/07/2020.
//

import Foundation
import Alamofire

struct AlamofireManager {
    static let shared: Session = {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 5
        let sessionManager = Alamofire.Session(configuration: configuration, delegate: SessionDelegate(), serverTrustManager: nil)
        return sessionManager
    }()
}

class APIManager {
    
    static let shared = APIManager()
    
    func request(route: APIRoute, completion: @escaping (Data?, Error?) -> ()) {
        let method = route.method
        let url = "\(Constants.API_URL)\(route.path)"
            
        AlamofireManager.shared.request(
            url,
            method: method,
            parameters: (method == .get ? nil : route.parameters),
            encoding: JSONEncoding.default,
            headers: route.headers
        ).validate()
        .responseJSON { (response) in
            switch response.result {
                case .success:
                    completion(response.data, nil)
                case .failure(let error):
                    completion(nil, error)
            }
        }
    }
    
    enum Result<Value> {
        case success(Value)
        case errorNetwork(Error)
        case errorDecoding(Error)
    }
    
    func fetchJSONData<T: Decodable>(route: APIRoute, completion: ((Result<T>) -> Void)?) {
        print("Fetching : \(route.path)...")
        
        request(route: route) { (data, error) in
            if let error = error {
                print("Can't fecth : \(route.path) : \(error)")
                
                completion?(.errorNetwork(error))
            }
            
            guard let data = data else {
                completion?(.errorDecoding(NSError(domain: "Data empty!", code: 0, userInfo: nil)))
                return
            }
            
            do {
                let objects = try JSONDecoder().decode(T.self, from: data)
                completion?(.success(objects))
                
            } catch let jsonError {
                print("Error decoding : \(route.path) => \(jsonError)")

                completion?(.errorDecoding(jsonError))
            }
        }
    }
    
}
