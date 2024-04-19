//
//  BaseViewController.swift
//  NewsList
//
//  Created by Junyoung Kil on 4/18/24.
//

import UIKit

class BaseViewController<T: BaseViewModel>: UIViewController {
    
    var viewModel: T!
    
    func initViewModel(_ viewModel: T) {
        self.viewModel = viewModel
    }
}

protocol BaseViewControllerProtocol {
    func setUI()
    func bindViewModel()
}
