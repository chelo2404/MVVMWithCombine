//
//  HomeListViewModel.swift
//  MVVMWithClosures
//
//  Created by Marcelo Fernandez on 26/06/2022.
//

import Foundation

class HomeListViewModel {
    @Published var dataArray: [Band] = []
    
    func getBands() {
        BandRepository.getBands { [weak self] response in
            switch response {
            case .success(bands: let bands):
                self?.dataArray = bands
            case .error(message: let message):
                self?.dataArray = [Band(name: message, logo: nil, image: nil, info: nil, genre: nil)]
            }
        }
    }
}
