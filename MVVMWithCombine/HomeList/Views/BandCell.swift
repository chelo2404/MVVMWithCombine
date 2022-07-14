//
//  BandCell.swift
//  MVVMWithClosures
//
//  Created by Marcelo Fernandez on 26/06/2022.
//

import Foundation
import UIKit

class BandCell: UITableViewCell {
    @IBOutlet weak var bandLogo: UIImageView!
    @IBOutlet weak var bandName: UILabel!
    
    static let identifier = "BandCell"
    
    func configureCellWith(viewModel: BandCellViewModel) {
        if let logo = viewModel.logo {
            bandLogo.load(url: logo)
        }
        bandName.text = viewModel.name
    }
}
