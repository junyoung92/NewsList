//
//  NewsListViewModel.swift
//  NewsList
//
//  Created by Junyoung Kil on 4/20/24.
//

import Combine

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
}
