//
//  DetailsViewModel.swift
//  MVVMWithClosures
//
//  Created by Marcelo Fernandez on 26/06/2022.
//

import Foundation

class DetailsViewModel {
    @Published var bandData: Band?
    
    func getBandData(with id: Int) {
        BandRepository.getBandInfo(with: id) { [weak self] band in
            self?.bandData = band
        }
    }
}
