//
//  MessagesOperation.swift
//  Arcadia
//
//  Created by João Santos Sena on 12/07/23.
//

import Foundation
import Alamofire

class MessagesOperation: BaseOperation {
    static func execute(
        _ session: Session,
        _ profile: Int,
        _ until: String,
        _ count: Int
    ) async -> Result<MessagesPage, AFError> {
        var components = URLComponents(string: "\(baseUrl)/diario/recados")!
        components.queryItems = [
            URLQueryItem(name: "idPessoa", value: String(profile)),
            URLQueryItem(name: "ate", value: until),
            URLQueryItem(name: "quantidade", value: String(count)),
            URLQueryItem(name: "perfil", value: "1"),
            URLQueryItem(name: "campos", value: "itens(id,descricao,timeStamp,remetente(nome),perfilRemetente,escopos(itens(id,tipo,classe(id,descricao,tipo,atividadeCurricular(id,codigo,nome,nomeResumido,ementa,cargaHoraria,departamento(nome)))))),maisAntigos"),
            URLQueryItem(name: "embutir", value: "itens(remetente,escopos(itens(classe(atividadeCurricular(departamento)))))")
        ]
        
        let response = await session.request(components).validate()
            .serializingDecodable(ItemsTimed<MessageDTO>.self)
            .result
        
        
        switch(response) {
        case .failure(let error):
            return .failure(error)
        case .success(let items):
            let page = processItems(items)
            return .success(page)
        }
    }
    
    static func processItems(_ items: ItemsTimed<MessageDTO>) -> MessagesPage {
        let mapped = items.items.map { item in
            let discipline = item.scopes.items.first?.clazz.map { clazz in
                MessageDisciplineData(
                    disciplineId: clazz.discipline.id,
                    classId: clazz.id,
                    code: clazz.discipline.code,
                    discipline: clazz.discipline.name,
                    group: clazz.type)
            }
            return Message(
                id: item.id,
                content: item.message,
                sender: item.sender.name,
                timestamp: item.timestamp,
                senderType: item.profileType,
                discipline: discipline)
        }
        
        var nextPage: String? = nil
        
        if let link = items.nextPage?.link.href {
            let regex = try? NSRegularExpression(
                pattern: "ate=(\\d+-\\d+)",
                options: .caseInsensitive
            )
            if let match = regex?.firstMatch(in: link, options: [], range: NSRange(location: 0, length: link.utf16.count)) {
                if match.numberOfRanges > 1, let range = Range(match.range(at: 1), in: link) {
                    nextPage = String(link[range])
                }
            }
        }
        
        return MessagesPage(
            messages: mapped,
            nextPage: nextPage
        )
    }
}
