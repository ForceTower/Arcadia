//
//  File.swift
//  
//
//  Created by João Santos Sena on 12/07/23.
//

import Foundation

public struct MessagesPage: Codable {
    public let messages: [Message]
    public let nextPage: String?
}

public struct Message: Codable, Identifiable {
    public let id: Int
    public let content: String
    public let sender: String
    public let timestamp: String
    public let senderType: Int
    public let discipline: MessageDisciplineData?
}

public struct MessageDisciplineData: Codable {
    public let disciplineId: Int
    public let classId: Int
    public let code: String
    public let discipline: String
    public let group: String
}
