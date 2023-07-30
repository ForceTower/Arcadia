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
        if let url = request.url,
           var components = URLComponents(url: url, resolvingAgainstBaseURL: false),
           var items = components.queryItems {
            items.append(URLQueryItem(name: "_", value: "\(Int(Date().timeIntervalSince1970 * 1000))"))
            components.queryItems = items
            request.url = components.url
        }
        completion(.success(request))
    }
}
