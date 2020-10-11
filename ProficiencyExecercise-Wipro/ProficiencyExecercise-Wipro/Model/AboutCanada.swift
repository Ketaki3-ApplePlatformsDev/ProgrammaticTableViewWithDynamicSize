//
//  AboutCanada.swift
//  ProficiencyExecercise-Wipro
//
//  Created by Ketaki Mahaveer Kurade on 11/10/20.
//

import Foundation

struct AboutCanada: Decodable {
    var title: String?
    var description: String?
    var imageURL: String?
    
    enum CodingKeys: String, CodingKey {
        case title
        case description
        case imageURL = "imageHref"
    }
}
