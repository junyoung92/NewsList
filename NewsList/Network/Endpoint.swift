//
//  Endpoint.swift
//  NewsList
//
//  Created by Junyoung Kil on 4/20/24.
//

import Alamofire

final class Endpoint {

    let path: String
    let httpMethod: HTTPMethod
    let headerParameters: HTTPHeaders?
    let queryParameters: Parameters?
    let bodyParameters: Parameters?

    init(path: String,
         httpMethod: HTTPMethod,
         headerParameters: HTTPHeaders? = nil,
         queryParameters: Parameters? = nil,
         bodyParameters: Parameters? = nil) {
        self.path = path
        self.httpMethod = httpMethod
        self.headerParameters = headerParameters
        self.queryParameters = queryParameters
        self.bodyParameters = bodyParameters
    }
}

