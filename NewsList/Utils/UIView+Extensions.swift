//
//  UIView+Extensions.swift
//  NewsList
//
//  Created by Junyoung Kil on 4/20/24.
//

import UIKit

extension UICollectionView {
    func registerNib<T: UICollectionViewCell>(_: T.Type) {
        self.register(T.nib, forCellWithReuseIdentifier: T.identifier)
    }
    
    func dequeue<T: UICollectionViewCell>(_: T.Type, for indexPath: IndexPath) -> T? {
        return dequeueReusableCell(withReuseIdentifier: T.identifier, for: indexPath) as? T
    }
}

extension UICollectionViewCell {
    class var identifier: String { return String(describing: self) }
    class var nib: UINib { return UINib(nibName: identifier, bundle: nil) }
}

extension UIView {
    func setCornerRadius(_ radius: CGFloat) {
        self.layer.cornerRadius = radius
        self.clipsToBounds = true
    }
    
    public func setShadow() {
        self.layer.shadowColor =  UIColor.black.cgColor
        self.layer.shadowOpacity = 0.1
        self.layer.shadowRadius = 8 / UIScreen.main.scale
        self.layer.shadowOffset = CGSize(width: 1, height: 2)
        self.layer.masksToBounds = false
    }
}

extension UIImageView {
    func setImage(path: String?) {
        guard let path = path else {
            return
        }
        
        NetworkManager.shared.requestImage(path) { [weak self] image in
            self?.image = image
        }
    }
}

extension UIStoryboard {
    public func instantiate<T: UIViewController>(viewController: T.Type) -> T? {
        return self.instantiateViewController(withIdentifier: String(describing: T.self)) as? T
    }
}
