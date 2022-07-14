//
//  UIImageView+.swift
//  MVVMWithClosures
//
//  Created by Marcelo Fernandez on 26/06/2022.
//

import Foundation
import UIKit

extension UIImageView {
    func load(url: URL?) {
        DispatchQueue.global().async { [weak self] in
            if let url = url, let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            } else {
                DispatchQueue.main.async {
                    self?.image = UIImage(named: "placeholder")
                }
            }
        }
    }
}
