//
//  NewsListItemCollectionViewCell.swift
//  NewsList
//
//  Created by Junyoung Kil on 4/20/24.
//

import UIKit
import Combine

class NewsListItemCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var rootView: UIView!
    @IBOutlet var thumbnailImageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var publishedDateLabel: UILabel!
    
    private var cellViewModel: NewsListCellViewModel?
    private var cancellable: Set<AnyCancellable> = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        rootView.setCornerRadius(20)
        rootView.setShadow()
        
        thumbnailImageView.contentMode = .scaleAspectFill
        
        titleLabel.font = .systemFont(ofSize: 16, weight: .bold)
        publishedDateLabel.font = .systemFont(ofSize: 10, weight: .regular)
    }
    
    func configureCell(_ cellViewModel: BaseCellViewModel) {
        guard let cellViewModel = cellViewModel as? NewsListCellViewModel else {
            return
        }
        
        self.cellViewModel = cellViewModel
        
        cellViewModel.$isSelected
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.titleLabel.textColor = cellViewModel.titleTextColor
            }.store(in: &cancellable)
        
        thumbnailImageView.setImage(path: cellViewModel.imageUrl)
        titleLabel.text = cellViewModel.title
        titleLabel.textColor = cellViewModel.titleTextColor
        publishedDateLabel.text = cellViewModel.publishedAt
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        cellViewModel?.isSelected = true
        super.touchesEnded(touches, with: event)
    }
}
