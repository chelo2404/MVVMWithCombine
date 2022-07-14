//
//  BandRepository.swift
//  MVVMWithClosures
//
//  Created by Marcelo Fernandez on 26/06/2022.
//

import Foundation

struct BandRepository {
    static private let bandsUrl = "https://jsonkeeper.com/b/U8AV"
    static private let emptyMessage = "There are no bands to show at the moment. Please try again later."
    
    static func getBands(completionHandler: @escaping (BandsResponse) -> Void) {
        NetworkService.getDataFrom(url: URL(string: bandsUrl)) { state in
            switch state {
            case .success(data: let data):
                let bands = self.parseResponse(data)
                if bands.isEmpty {
                    completionHandler(.error(message: emptyMessage))
                } else {
                    completionHandler(.success(bands: bands))
                }
            case .error(message: let message):
                completionHandler(.error(message: message))
            case .empty:
                completionHandler(.error(message: emptyMessage))
            }
        }
    }
    
    static func getBandInfo(with id: Int, completionHandler: @escaping (Band?) -> Void) {
        // TODO: This could be improved by using a caching system. It was done this way to show how MVVM works.
        NetworkService.getDataFrom(url: URL(string: bandsUrl)) { state in
            switch state {
            case .success(data: let data):
                let bands = self.parseResponse(data)
                if bands.isEmpty {
                    completionHandler(nil)
                } else {
                    completionHandler(bands[id])
                }
            case .error(message: _), .empty:
                completionHandler(nil)
            }
        }
    }
    
    static private func parseResponse(_ data: Data) -> [Band] {
        do {
            let decodedData = try JSONDecoder().decode([Band].self, from: data)
            return decodedData
        } catch {
            print("An error ocurred trying to decode the server response.")
            return []
        }
    }
}

enum BandsResponse {
    case success(bands:[Band])
    case error(message:String)
}
