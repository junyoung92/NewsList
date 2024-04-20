//
//  Endpoint.swift
//  NewsList
//
//  Created by Junyoung Kil on 4/20/24.
//

import Alamofire

final class Endpoint<R> {

    typealias Response = R
    
    let path: String
    let httpMethod: HTTPMethod
    let headerParameters: HTTPHeaders?
    let queryParameters: Encodable?
    let bodyParameters: Encodable?

    init(path: String,
         httpMethod: HTTPMethod,
         headerParameters: HTTPHeaders? = nil,
         queryParameters: Encodable? = nil,
         bodyParameters: Encodable? = nil) {
        self.path = path
        self.httpMethod = httpMethod
        self.headerParameters = headerParameters
        self.queryParameters = queryParameters
        self.bodyParameters = bodyParameters
    }
}

