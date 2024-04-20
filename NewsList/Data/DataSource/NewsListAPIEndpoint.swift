//
//  NewsListAPIEndpoint.swift
//  NewsList
//
//  Created by Junyoung Kil on 4/20/24.
//

import Foundation

struct NewsListAPIEndpoint {
    static func fetchNewsList(_ request: NewsRequestDTO) -> Endpoint<NewsResponseDTO> {
        return Endpoint(path: "/v2/top-headlines",
                        httpMethod: .get,
                        queryParameters: request)
    }
}
