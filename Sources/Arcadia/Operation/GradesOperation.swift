//
//  GradesOperation.swift
//  Arcadia
//
//  Created by João Santos Sena on 12/07/23.
//

import Alamofire
import Foundation

class GradesOperation: BaseOperation {
    static func execute(_ session: Session, _ profileId: Int, _ semesterId: Int) async -> Result<[DisciplineData], AFError> {
        var components = URLComponents(string: "\(baseUrl)/diario/periodos-letivos/\(semesterId)")!
        components.queryItems = [
            URLQueryItem(name: "idPessoa", value: String(profileId)),
            URLQueryItem(name: "perfil", value: "1"),
            URLQueryItem(name: "campos", value: "id,codigo,descricao,turmas(itens(id,limiteFaltas,resultado(-%24link),classes(itens(atividadeCurricular(id,ementa,cargaHoraria),id,descricao,tipo,professores(itens(pessoa(id,nome,email,tipoPessoa))),alocacoes(itens(espacoFisico,horario)))),atividadeCurricular(id,nome,codigo,ementa,cargaHoraria,departamento(nome)),ultimaAula(data),proximaAula(data),avaliacoes(itens(nome,nomeResumido,nota,avaliacoes(itens(nome,ordinal,nomeResumido,data,peso,nota(valor))))),periodoLetivo(codigo)))"),
            URLQueryItem(name: "embutir", value: "turmas(itens(resultado,classes(itens(atividadeCurricular,professores(itens(pessoa)),alocacoes(itens(espacoFisico,horario)))),atividadeCurricular(departamento(nome)),ultimaAula,proximaAula,avaliacoes(itens(avaliacoes(itens(nota)))),periodoLetivo(codigo)))")
        ]
        
        let response = await session.request(components)
            .validate()
            .serializingDecodable(SemesterCompleteDTO.self)
            .result
        
        return response.map { item in
            item.disciplines.items.map { discipline in
                discipline.asDisciplineData()
            }
        }
    }
}
