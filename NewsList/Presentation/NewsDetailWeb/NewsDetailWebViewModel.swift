//
//  NewsDetailWebViewModel.swift
//  NewsList
//
//  Created by Junyoung Kil on 4/20/24.
//

import Foundation

class NewsDetailWebViewModel: BaseViewModel {
    
    var title: String
    var url: String
    
    init(title: String, url: String) {
        self.title = title
        self.url = url
    }
}
