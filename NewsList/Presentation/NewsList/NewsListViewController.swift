//
//  NewsListViewController.swift
//  NewsList
//
//  Created by Junyoung Kil on 4/20/24.
//

import Combine
import UIKit

class NewsListViewController: BaseViewController<NewsListViewModel>, BaseViewControllerProtocol {
    
    @IBOutlet var newsCollectionView: UICollectionView!
    private var cancellable: Set<AnyCancellable> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(orientationDidChange), name: UIDevice.orientationDidChangeNotification, object: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        setUI()
        bindViewModel()
    }
    
    func setUI() {
        setCollectionView()
    }
    
    func bindViewModel() {
        initViewModel(NewsListViewModel())
        viewModel.getData()
        viewModel.$cellViewModels
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.newsCollectionView.reloadData()
            }
            .store(in: &cancellable)
    }
    
    private func setCollectionView() {
        newsCollectionView.delegate = self
        newsCollectionView.dataSource = self
        newsCollectionView.registerNib(NewsListItemCollectionViewCell.self)
    }
    
    
    @objc func orientationDidChange() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { [weak self] in
            self?.newsCollectionView.reloadData()
        }
    }
}

extension NewsListViewController: UICollectionViewDelegate,
                                  UICollectionViewDataSource,
                                  UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let cell = collectionView.dequeue(NewsListItemCollectionViewCell.self, for: indexPath),
              let interfaceOrientation = (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.interfaceOrientation else {
            return .zero
        }
        
        cell.configureCell(viewModel.cellViewModels[indexPath.row])
        cell.titleLabel.sizeToFit()
        cell.publishedDateLabel.sizeToFit()
        
        let cellWidth = collectionView.frame.width / (interfaceOrientation == .portrait || interfaceOrientation == .portraitUpsideDown ? 1 : 3)
        let imageHeight = cellWidth / 7 * 3
        return CGSize(width: cellWidth, height: imageHeight + cell.titleLabel.frame.height + cell.publishedDateLabel.frame.height + 56)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let vc = self.storyboard?.instantiate(viewController: NewsDetailWebViewController.self) {
            vc.viewModel = viewModel.getNewsDetailWebViewModel(indexPath)
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItemsInSection
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeue(NewsListItemCollectionViewCell.self, for: indexPath) {
            cell.configureCell(viewModel.cellViewModels[indexPath.row])
            return cell
        }
        return UICollectionViewCell()
    }
}
