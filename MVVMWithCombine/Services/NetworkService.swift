//
//  NetworkService.swift
//  MVVMWithClosures
//
//  Created by Marcelo Fernandez on 26/06/2022.
//

import Foundation

struct NetworkService {
    static func getDataFrom(url: URL?, completionHandler: @escaping ((ResponseState) -> Void)) {
        guard let url = url else {
            completionHandler(.empty)
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                completionHandler(.empty)
                return
            }
            
            if let error = error {
                completionHandler(.error(message: error.localizedDescription))
            } else {
                completionHandler(.success(data: data))
            }
        }.resume()
    }
    
    enum ResponseState {
        case success(data:Data)
        case error(message: String)
        case empty
    }
}
