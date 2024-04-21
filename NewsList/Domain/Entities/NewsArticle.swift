//
//  NewsArticle.swift
//  NewsList
//
//  Created by Junyoung Kil on 4/20/24.
//

import Foundation

struct NewsArticle: Codable {
    var title: String
    var url: String
    var urlToImage: String?
    var publishedAt: String
}
