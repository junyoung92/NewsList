//
//  NewsListCellViewModel.swift
//  NewsList
//
//  Created by Junyoung Kil on 4/20/24.
//

import Foundation

class NewsListCellViewModel: BaseCellViewModel {
    
    private (set) var url: String? = nil
    private (set) var imageUrl: String? = nil
    private (set) var title: String = ""
    private (set) var publishedAt: String = ""
    
    init(data: Any) {
        if let article = data as? NewsArticle {
            url = article.url
            imageUrl = article.urlToImage
            title = article.title
            publishedAt = article.publishedAt
        }
        super.init()
        self.data = data
    }
}
