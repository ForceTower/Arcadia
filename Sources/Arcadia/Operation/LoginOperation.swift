//
//  LoginOperation.swift
//  Arcadia
//
//  Created by João Santos Sena on 11/07/23.
//

import Alamofire
import Foundation

class LoginOperation : BaseOperation {
    static func execute(_ session: Session) async -> Result<Person, AFError> {
        let url = "\(baseUrl)/eu"
        return await session.request(url)
            .validate()
            .serializingDecodable(Person.self)
            .result
    }
}
