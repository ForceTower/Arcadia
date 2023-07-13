//
//  Semester.swift
//  Arcadia
//
//  Created by João Santos Sena on 12/07/23.
//

import Foundation

public struct Semester: Identifiable, Codable {
    public let id: Int
    public let code: String
    public let description: String
    public let start: String
    public let end: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case code = "codigo"
        case description = "descricao"
        case start = "inicio"
        case end = "fim"
    }
}
