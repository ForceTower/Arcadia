//
//  DisciplineData.swift
//  Arcadia
//
//  Created by João Santos Sena on 12/07/23.
//

import Foundation

public struct DisciplineData: Identifiable, Codable {
    public let id: Int
    public let disciplineId: Int
    public let name: String
    public let code: String
    public let program: String?
    public let hours: Int
    public let department: String?
    public let classes: [DisciplineClass]
    public let evaluations: [ClassEvaluation]
    public let result: DisciplineResult?
}

public struct DisciplineClass: Identifiable, Codable {
    public let id: Int
    public let groupName: String
    public let type: String
    public let teacher: Person?
    public let hours: Int
    public let program: String?
    public let allocations: [Allocation]
    public let lectures: [Lecture]
}

public struct ClassEvaluation: Codable {
    public let name: String?
    public let grades: [ClassGrade]
}

public struct ClassGrade: Codable {
    public let ordinal: Int
    public let name: String
    public let nameShort: String
    public let date: String?
    public let weight: Int
    public let value: Double?
    
    public func hasGrade() -> Bool {
        return value != nil
    }
}

public struct Allocation: Codable {
    public let time: ClassTime?
    public let space: ClassSpace?
    
    enum CodingKeys: String, CodingKey {
        case time = "horario"
        case space = "espacoFisico"
    }
}

public struct ClassTime: Identifiable, Codable {
    public let id: Int
    public let day: Int
    public let start: String
    public let end: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case day = "dia"
        case start = "inicio"
        case end = "fim"
    }
}

public struct ClassSpace: Identifiable, Codable {
    public let id: Int
    public let type: String?
    public let campus: String
    public let location: String
    public let modulo: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case type = "tipo"
        case campus = "pavilhao"
        case location = "numero"
        case modulo = "localizacao"
    }
}

public struct DisciplineResult: Codable {
    public let mean: Double?
    public let missedClasses: Int?
    public let description: String?
    public let approved: Bool?
    public let underRevision: Bool?
    
    enum CodingKeys: String, CodingKey {
        case mean = "media"
        case missedClasses = "totalFaltas"
        case description = "descricao"
        case approved = "aprovado"
        case underRevision = "emRevisao"
    }
}

public struct Lecture: Codable {
    public let ordinal: Int
    public let situation: Int
    public let date: String?
    public let subject: String?
    public let materials: [LectureMaterial]
}

public struct LectureMaterial: Identifiable, Codable {
    public let id: Int
    public let description: String
    public let url: String
}
