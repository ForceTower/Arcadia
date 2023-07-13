//
//  Person.swift
//  Arcadia
//
//  Created by João Santos Sena on 11/07/23.
//

import Foundation

public struct Person: Codable, Identifiable {
    public let id: Int
    public let name: String
    public let kind: String
    public let cpf: String?
    public let email: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "nome"
        case kind = "tipoPessoa"
        case cpf = "cpf"
        case email = "email"
    }
}
