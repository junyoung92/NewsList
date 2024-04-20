//
//  NewsListRepository.swift
//  NewsList
//
//  Created by Junyoung Kil on 4/20/24.
//

import Combine

final class NewsListRepository: NewsListRepositoryInterface {

    private let dataSource: NewsListDataSourceInterface

    init(dataSource : NewsListDataSourceInterface) {
        self.dataSource = dataSource
    }

    func fetchNewsList(query: NewsQuery) -> AnyPublisher<News, Error> {
        let request = NewsRequestDTO(country: query.country,
                                     category: query.category)
        return dataSource.fetchNewsList(request: request)
            .map { response in
                return response.toEntity()
            }
            .eraseToAnyPublisher()
    }
}
