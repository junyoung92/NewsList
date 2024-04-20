//
//  BaseViewModel.swift
//  NewsList
//
//  Created by Junyoung Kil on 4/18/24.
//

import Combine

class BaseViewModel {
    
}

protocol BaseViewModelProtocol {
    associatedtype Input
    associatedtype Output
    
    func transform(input: Input) -> Output
    
//    func getData() -> AnyPublisher<Any, Never>
//    func fetchData(_ data: Any?)
}
