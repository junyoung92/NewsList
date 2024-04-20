//
//  NewsResponseDTO.swift
//  NewsList
//
//  Created by Junyoung Kil on 4/20/24.
//

import Foundation

struct NewsResponseDTO: Codable {
    let totalResults: Int
    let articles: [NewsArticleDTO]
}

extension NewsResponseDTO {
    struct NewsArticleDTO: Codable {
        var title: String
        var urlToImage: String
        var publishedAt: String
    }
}

extension NewsResponseDTO {
    func toEntity() -> News {
        return .init(totalResults: totalResults,
                     articles: articles.map { $0.toEntity() })
    }
}

extension NewsResponseDTO.NewsArticleDTO {
    func toEntity() -> NewsArticle {
        return .init(title: title, 
                     urlToImage: urlToImage,
                     publishedAt: publishedAt)
    }
}
