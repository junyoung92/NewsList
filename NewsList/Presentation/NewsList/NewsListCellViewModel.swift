//
//  NewsListCellViewModel.swift
//  NewsList
//
//  Created by Junyoung Kil on 4/20/24.
//

import Foundation

class NewsListCellViewModel: BaseCellViewModel {
    
    var imageUrl: String? = nil
    var title: String = ""
    var publishedAt: String = ""
    
    init(data: Any) {
        if let article = data as? NewsArticle {
            imageUrl = article.urlToImage
            title = article.title
            publishedAt = article.publishedAt
        }
        super.init()
        self.data = data
    }
}
