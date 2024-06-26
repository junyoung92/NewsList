//
//  BaseListViewModel.swift
//  NewsList
//
//  Created by Junyoung Kil on 4/18/24.
//

import Combine
import Foundation

class BaseListViewModel: BaseViewModel {
    
    @Published var cellViewModels = [BaseCellViewModel]()
    
    var numberOfItemsInSection: Int {
        return cellViewModels.count
    }
}

protocol BaseListViewModelProtocol: BaseViewModelProtocol {
    func createCellViewModel(_ data: Any?) -> BaseCellViewModel?
    func getCellViewModel(_ indexPath: IndexPath) -> BaseCellViewModel
}
