//
//  AllAboutCanada.swift
//  ProficiencyExecercise-Wipro
//
//  Created by Ketaki Mahaveer Kurade on 11/10/20.
//

import Foundation

/// Model used to parse the JSON response
struct AllAboutCanada: Codable {
    var title: String
    var all: [AboutCanada]
    
    enum CodingKeys: String, CodingKey {
        case title
        case all = "rows"
    }
}
