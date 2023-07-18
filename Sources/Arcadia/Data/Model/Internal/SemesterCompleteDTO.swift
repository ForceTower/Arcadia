//
//  SemesterCompleteDTO.swift
//  Arcadia
//
//  Created by João Santos Sena on 12/07/23.
//

import Foundation

struct SemesterCompleteDTO: Decodable {
    let id: Int
    let code: String
    let description: String
    let start: String?
    let end: String?
    let disciplines: Items<DisciplineCompleteDTO>
    
    enum CodingKeys: String, CodingKey {
        case id
        case code = "codigo"
        case description = "descricao"
        case start = "inicio"
        case end = "fim"
        case disciplines = "turmas"
    }
}

struct DisciplineCompleteDTO: Decodable {
    let id: Int
    let missLimit: Int?
    let activity: DisciplineDTO
    let classes: Items<ClassCompleteDTO>
    let evaluations: Items<EvaluationDTO>?
    let result: DisciplineResult?
    
    enum CodingKeys: String, CodingKey {
        case id
        case classes
        case missLimit = "limiteFaltas"
        case activity = "atividadeCurricular"
        case evaluations = "avaliacoes"
        case result = "resultado"
    }
}

struct ClassCompleteDTO: Decodable {
    let id: Int
    let description: String
    let type: String
    let allocations: Items<Allocation>?
    let teachers: Items<PersonWrapperDTO>
    let groupDetails: GroupDTO
    let lectures: ItemsPaged<LectureDTO>?
    
    enum CodingKeys: String, CodingKey {
        case id
        case description = "descricao"
        case type = "tipo"
        case allocations = "alocacoes"
        case teachers = "professores"
        case groupDetails = "atividadeCurricular"
        case lectures = "aulas"
    }
}

struct EvaluationDTO: Decodable {
    let name: String?
    let grades: Items<GradeDTO>?
    
    enum CodingKeys: String, CodingKey {
        case name = "nome"
        case grades = "avaliacoes"
    }
}

struct GradeDTO: Decodable {
    let ordinal: Int
    let name: String
    let nameShort: String
    let date: String?
    let weight: Int
    let grade: GradeValueDTO?
    
    enum CodingKeys: String, CodingKey {
        case ordinal
        case name = "nome"
        case nameShort = "nomeResumido"
        case date = "data"
        case weight = "peso"
        case grade = "nota"
    }
}

struct GradeValueDTO: Decodable {
    let value: Double?
    
    enum CodingKeys: String, CodingKey {
        case value = "valor"
    }
}

struct GroupDTO: Decodable {
    let id: Int
    let hours: Int
    let program: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case hours = "cargaHoraria"
        case program = "ementa"
    }
}

struct LectureDTO: Decodable {
    let ordinal: Int
    let situation: Int
    let date: String?
    let subject: String?
    let materials: Items<LectureMaterialDTO>?
    
    enum CodingKeys: String, CodingKey {
        case ordinal
        case situation = "situacao"
        case date = "data"
        case subject = "assunto"
        case materials = "materiaisApoio"
    }
}

struct LectureMaterialDTO: Decodable {
    let id: Int
    let description: String
    let url: Linker
    
    enum CodingKeys: String, CodingKey {
        case id
        case url
        case description = "descricao"
    }
}

struct PersonWrapperDTO: Decodable {
    let person: Person
    
    enum CodingKeys: String, CodingKey {
        case person = "pessoa"
    }
}
