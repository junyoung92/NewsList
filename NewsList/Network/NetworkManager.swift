//
//  NetworkManager.swift
//  NewsList
//
//  Created by Junyoung Kil on 4/20/24.
//

import Alamofire
import Combine
import Foundation

final class NetworkManager {
    
    static let shared = NetworkManager()
    
    func request<T: Codable>(endpoint: Endpoint) -> AnyPublisher<T, Error> {
        do {
            var urlRequest = try URLRequest(url: endpoint.path, method: endpoint.httpMethod)
            if let bodyParameters = endpoint.bodyParameters {
                urlRequest.httpBody = try JSONSerialization.data(withJSONObject: bodyParameters)
            }
            
            if let queryParameters = endpoint.queryParameters {
                urlRequest = try URLEncoding.queryString.encode(urlRequest, with: queryParameters)
            }
            
            return AF.request(urlRequest)
                .publishDecodable(type: T.self)
                .value()
                .mapError { $0 as Error }
                .eraseToAnyPublisher()
        } catch {
            return Fail(error: error).eraseToAnyPublisher()
        }
    }
}


