//
//  News.swift
//  NewsList
//
//  Created by Junyoung Kil on 4/20/24.
//

import Foundation

struct News: Codable {
    var totalResults: Int
    var articles: [NewsArticle]
}
