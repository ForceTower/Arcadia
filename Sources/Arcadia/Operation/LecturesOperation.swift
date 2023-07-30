//
//  LecturesOperation.swift
//  
//
//  Created by João Santos Sena on 29/07/23.
//

import Foundation
import Alamofire

class LecturesOperation: BaseOperation {
    static func execute(
        _ session: Session,
        _ classId: Int,
        _ limit: Int,
        _ offset: Int
    ) async -> Result<[Lecture], AFError> {
        var components = URLComponents(string: "\(baseUrl)/diario/aulas")!
        components.queryItems = [
            URLQueryItem(name: "idClasse", value: String(classId)),
            URLQueryItem(name: "quantidade", value: String(limit)),
            URLQueryItem(name: "tokenPagina", value: String(offset)),
            URLQueryItem(name: "campos", value: "proximaPagina,itens(planoAula,ordinal,data,situacao,assunto,materiaisApoio,tarefa)"),
            URLQueryItem(name: "embutir", value: "itens(materiaisApoio)")
        ]
        
        let response = await session.request(components)
            .validate()
            .serializingDecodable(Items<LectureDTO>.self)
            .result
        
        return response.map { result in
            result.items.map { dto in
                Lecture(
                    ordinal: dto.ordinal,
                    situation: dto.situation,
                    date: dto.date,
                    subject: dto.subject,
                    materials: dto.materials?.items.map({ material in
                        LectureMaterial(
                            id: material.id,
                            description: material.description,
                            url: material.url.link.href)
                    }) ?? [])
            }
        }
    }
}
