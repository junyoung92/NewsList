//
//  NewsListViewModel.swift
//  NewsList
//
//  Created by Junyoung Kil on 4/20/24.
//

import Combine
import Foundation

class NewsListViewModel: BaseListViewModel, BaseViewModelProtocol {
    
    struct Input {
        
    }
    
    struct Output {
        
    }
    
    func transform(input: Input) -> Output {
        return Output()
    }
    
    private let newsListUseCase: NewsListUseCase
    private var cancellable: Set<AnyCancellable> = []
    
    override init() {
        self.newsListUseCase = NewsListUseCase(newsListRepository: NewsListRepository(dataSource: NewsListDataSource()))
        super.init()
    }
    
    func getData() {
        newsListUseCase.fetchNewsList(query: NewsQuery(country: "kr", category: "general"))
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure( _):
                    break
                }
            } receiveValue: { [weak self] newsEntity in
                self?.cellViewModels = newsEntity.articles.map { NewsListCellViewModel(data: $0) }
            }
            .store(in: &cancellable)
    }
    
    func getNewsDetailWebViewModel(_ indexPath: IndexPath) -> NewsDetailWebViewModel {
        let cellViewModel = getCellViewModel(indexPath)
        return NewsDetailWebViewModel(title: cellViewModel?.title ?? "",
                                      url: cellViewModel?.url ?? "")
    }
    
    func getCellViewModel(_ indexPath: IndexPath) -> NewsListCellViewModel? {
        return cellViewModels[indexPath.row] as? NewsListCellViewModel
    }
}
