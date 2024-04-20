//
//  NewsListItemCollectionViewCell.swift
//  NewsList
//
//  Created by Junyoung Kil on 4/20/24.
//

import UIKit

class NewsListItemCollectionViewCell: UICollectionViewCell {

    @IBOutlet var rootView: UIView!
    @IBOutlet var thumbnailImageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var publishedDateLabel: UILabel!
    
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
        
        thumbnailImageView.setImage(path: cellViewModel.imageUrl)
        titleLabel.text = cellViewModel.title
        publishedDateLabel.text = cellViewModel.publishedAt
    }
}
