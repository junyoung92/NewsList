//
//  NewsDetailWebViewController.swift
//  NewsList
//
//  Created by Junyoung Kil on 4/20/24.
//

import UIKit
import WebKit

class NewsDetailWebViewController: BaseViewController<NewsDetailWebViewModel>, BaseViewControllerProtocol {
    
    @IBOutlet var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        setUI()
        bindViewModel()
        loadWebView()
    }
    
    func setUI() {
        self.title = viewModel.title
    }
    
    func bindViewModel() {
        
    }
    
    private func loadWebView() {
        webView.load(URLRequest(url: URL(string: viewModel.url)!))
    }
}
