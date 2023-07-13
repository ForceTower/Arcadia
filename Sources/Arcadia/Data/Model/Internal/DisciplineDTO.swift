//
//  DisciplineDTO.swift
//  Arcadia
//
//  Created by João Santos Sena on 12/07/23.
//

import Foundation

struct DisciplineDTO: Decodable {
    let id: Int
    let code: String
    let name: String
    let program: String?
    let hours: Int
    let department: DisciplineDepartment?
    
    enum CodingKeys: String, CodingKey {
        case id
        case code = "codigo"
        case name = "nome"
        case program = "ementa"
        case hours = "cargaHoraria"
        case department = "departamento"
    }
}

struct DisciplineDepartment: Decodable {
    let name: String
    
    enum CodingKeys: String, CodingKey {
        case name = "nome"
    }
}
