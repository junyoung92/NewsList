//
//  NewsListDataSource.swift
//  NewsList
//
//  Created by Junyoung Kil on 4/20/24.
//

import Combine

protocol NewsListDataSourceInterface {
    func fetchNewsList(request: NewsRequestDTO) -> AnyPublisher<NewsResponseDTO, Error>
}

final class NewsListDataSource : NewsListDataSourceInterface {

    func fetchNewsList(request: NewsRequestDTO) -> AnyPublisher<NewsResponseDTO, any Error> {
        let apiEndpoint = NewsListAPIEndpoint.fetchNewsList(request)
        return NetworkManager.shared.request(endpoint: apiEndpoint)
    }
}

