//
//  AboutCanada.swift
//  ProficiencyExecercise-Wipro
//
//  Created by Ketaki Mahaveer Kurade on 11/10/20.
//

import Foundation

/// Model to Parse Single JSON Dictionary
struct AboutCanada: Codable {
    var title: String?
    var description: String?
    var imageURL: String?
    
    enum CodingKeys: String, CodingKey {
        case title
        case description
        case imageURL = "imageHref"
    }
}
