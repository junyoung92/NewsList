//
//  NetworkManager.swift
//  NewsList
//
//  Created by Junyoung Kil on 4/20/24.
//

import Alamofire
import Combine
import Foundation
import UIKit

final class NetworkManager {
    
    static let shared = NetworkManager()
    
    func request<D: Codable>(endpoint: Endpoint<D>, fileName: String) -> AnyPublisher<D, Error> {
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
                .tryMap { response -> D in
                    if !(200...299).contains(response.response?.statusCode ?? 0) {
                        guard let cachedData: D = CacheManager.shared.getCacheData(fileName: fileName) else {
                            throw URLError(.badServerResponse)
                        }
                        return cachedData
                    }
                    guard let data = response.data else {
                        throw AFError.responseSerializationFailed(reason: .decodingFailed(error: URLError(.badServerResponse)))
                    }
                    let decodedData = try JSONDecoder().decode(D.self, from: data)
                    CacheManager.shared.cacheData(decodedData, fileName: fileName)
                    return decodedData
                }
                .mapError { $0 as Error }
                .eraseToAnyPublisher()
        } catch {
            return Fail(error: error).eraseToAnyPublisher()
        }
    }
    
    func requestImage(_ urlString: String, completionHandler: @escaping (UIImage?) -> Void) {
        guard let url = URL(string: urlString) else {
            completionHandler(nil)
            return
        }
     
        if let cachedImage = CacheManager.shared.getCacheImage(urlString: urlString) {
            completionHandler(cachedImage)
        }
        
        DispatchQueue.global(qos: .background).async {
            let request = URLRequest(url: url)
            URLSession.shared.dataTask(with: request) { data, reponse, error in
                if let data = data, let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        CacheManager.shared.cacheImage(image, urlString: urlString)
                        completionHandler(image)
                    }
                }
            }.resume()
        }
    }
}


