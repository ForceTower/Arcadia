//
//  GeneralTypes.swift
//  Arcadia
//
//  Created by João Santos Sena on 12/07/23.
//

import Foundation

struct Items<T: Decodable>: Decodable {
    let items: [T]
    
    enum CodingKeys: String, CodingKey {
        case items = "itens"
    }
}

struct ItemsTimed<T: Decodable>: Decodable {
    let nextPage: Linker?
    let previousPage: Linker?
    let items: [T]
    
    enum CodingKeys: String, CodingKey {
        case nextPage = "maisAntigos"
        case previousPage = "maisRecentes"
        case items = "itens"
    }
}

struct ItemsPaged<T: Decodable>: Decodable {
    let nextPage: Linker?
    let items: [T]
    
    enum CodingKeys: String, CodingKey {
        case nextPage = "proximaPagina"
        case items = "itens"
    }
}

struct Linker: Decodable {
    let link: Link
    
    enum CodingKeys: String, CodingKey {
        case link = "$link"
    }
}

struct Link: Decodable {
    let href: String
}
