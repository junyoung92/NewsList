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
    
    func request<D: Codable>(endpoint: Endpoint<D>) -> AnyPublisher<D, Error> {
        do {
            let url = AppConfiguration().apiBaseURL + endpoint.path
            var urlRequest = try URLRequest(url: url, method: endpoint.httpMethod)
            if let bodyParameters = endpoint.bodyParameters {
                urlRequest.httpBody = try JSONSerialization.data(withJSONObject: bodyParameters)
            }
            
            if let queryParameters = endpoint.queryParameters {
                let jsonEncoder = JSONEncoder()
                let jsonData = try jsonEncoder.encode(queryParameters)
                guard var jsonObject = try JSONSerialization.jsonObject(with: jsonData, options: []) as? [String: Any] else {
                    fatalError("Failed to convert JSON data to [String: Any]")
                }
                jsonObject["apiKey"] = AppConfiguration().apiKey
                urlRequest = try URLEncoding.queryString.encode(urlRequest, with: jsonObject)
            }
            
            return AF.request(urlRequest)
                .publishDecodable(type: D.self)
                .value()
                .mapError { $0 as Error }
                .eraseToAnyPublisher()
        } catch {
            return Fail(error: error).eraseToAnyPublisher()
        }
    }
}


