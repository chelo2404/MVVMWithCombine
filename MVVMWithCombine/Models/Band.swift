//
//  Band.swift
//  MVVMWithClosures
//
//  Created by Marcelo Fernandez on 26/06/2022.
//

import Foundation

struct Band: Codable {
    let name: String
    let logo: URL?
    let image: URL?
    let info: String?
    let genre: BandGenre?
    
    enum CodingKeys: String, CodingKey {
        case logo = "img_url"
        case image = "thumb1"
        case name, info, genre
    }
}

enum BandGenre: String, Codable {
    case HeavyMetal = "Heavy Metal"
    case Rock = "Rock"
    case HardRock = "Hard Rock"
    case Grunge = "Grunge"
}
