//
//  NewsListUseCase.swift
//  NewsList
//
//  Created by Junyoung Kil on 4/20/24.
//

import Combine

final class NewsListUseCase {
    
    private let newsListRepository: NewsListRepositoryInterface
    
    init(newsListRepository: NewsListRepositoryInterface) {
        self.newsListRepository = newsListRepository
    }
    
    func fetchNewsList(query: NewsQuery) -> AnyPublisher<News, Error> {
        return newsListRepository
            .fetchNewsList(query: query)
            .eraseToAnyPublisher()
    }
}
