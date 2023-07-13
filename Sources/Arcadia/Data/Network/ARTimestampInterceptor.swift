//
//  ARTimestampInterceptor.swift
//  Arcadia
//
//  Created by João Santos Sena on 11/07/23.
//

import Alamofire
import Foundation

class ARTimestampInterceptor: RequestInterceptor {
    func adapt(_ urlRequest: URLRequest, for session: Alamofire.Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        var request = urlRequest
        if var url = request.url {
            url.append(queryItems: [
                URLQueryItem(name: "_", value: "\(Int(Date().timeIntervalSince1970 * 1000))")
            ])
            request.url = url
        }
        completion(.success(request))
    }
}
