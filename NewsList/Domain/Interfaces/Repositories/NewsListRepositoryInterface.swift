//
//  NewsListRepositoryInterface.swift
//  NewsList
//
//  Created by Junyoung Kil on 4/20/24.
//

import Combine

protocol NewsListRepositoryInterface {
    func fetchNewsList(query: NewsQuery) -> AnyPublisher<News, Error>
}
