//
//  MessageDTO.swift
//  Arcadia
//
//  Created by João Santos Sena on 12/07/23.
//

import Foundation

struct MessageDTO: Decodable {
    let id: Int
    let message: String
    let profileType: Int
    let timestamp: String
    let sender: Sender
    let scopes: Items<MessageScopeDTO>
    
    enum CodingKeys: String, CodingKey {
        case id
        case message = "descricao"
        case profileType = "perfilRemetente"
        case timestamp = "timeStamp"
        case sender = "remetente"
        case scopes = "escopos"
    }
}

struct Sender: Decodable {
    let name: String
    
    enum CodingKeys: String, CodingKey {
        case name = "nome"
    }
}

struct MessageScopeDTO: Decodable {
    let id: Int
    let type: Int
    let clazz: MessageClassResumed?
    
    enum CodingKeys: String, CodingKey {
        case id
        case type = "tipo"
        case clazz = "classe"
    }
}

struct MessageClassResumed: Decodable {
    let id: Int
    let description: String
    let type: String
    let discipline: DisciplineDTO
    
    enum CodingKeys: String, CodingKey {
        case id
        case description = "descricao"
        case type = "tipo"
        case discipline = "atividadeCurricular"
    }
}
