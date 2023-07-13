//
//  SemesterOperation.swift
//  Arcadia
//
//  Created by João Santos Sena on 12/07/23.
//

import Alamofire
import Foundation

class SemesterOperation: BaseOperation {
    static func execute(_ session: Session, _ profileId: Int) async -> Result<[Semester], AFError> {
        var components = URLComponents(string: "\(baseUrl)/diario/periodos-letivos")!
        components.queryItems = [
            URLQueryItem(name: "idPessoa", value: String(profileId)),
            URLQueryItem(name: "perfil", value: "1"),
            URLQueryItem(name: "campos", value: "itens(id,codigo,descricao,inicio,fim)"),
            URLQueryItem(name: "quantidade", value: "0")
        ]
        
        let response = await session.request(components)
            .validate()
            .serializingDecodable(Items<Semester>.self)
            .result
        
        return response.map(\.items)
    }
}
