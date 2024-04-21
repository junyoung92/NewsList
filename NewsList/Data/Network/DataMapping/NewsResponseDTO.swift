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
        var url: String
        var urlToImage: String?
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
                     url: url,
                     urlToImage: urlToImage,
                     publishedAt: dateFormatter.string(from: dateFormatter.date(from: publishedAt) ?? Date()))
    }
}

private let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd HH:mm"
    formatter.calendar = Calendar(identifier: .iso8601)
    formatter.timeZone = TimeZone(identifier: "Asia/Seoul")
    formatter.locale = Locale(identifier: "ko_KR")
    return formatter
}()
