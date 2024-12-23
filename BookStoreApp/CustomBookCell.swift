//
//  CustomBookCell.swift
//  BookStoreApp
//
//  Created by Полина Соколова on 23.12.24.
//

import UIKit

class CustomBookCell: UICollectionViewCell {
    private let imageView = UIImageView()
    private let titleLabel = UILabel()
    private let badgeLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 5
        contentView.addSubview(imageView)
        
        titleLabel.font = UIFont.systemFont(ofSize: 14)
        titleLabel.textColor = .white
        titleLabel.textAlignment = .left
        contentView.addSubview(titleLabel)
        
        badgeLabel.font = UIFont.systemFont(ofSize: 10, weight: .semibold)
        badgeLabel.textColor = .white
        badgeLabel.textAlignment = .center
        badgeLabel.backgroundColor = .systemPurple
        badgeLabel.layer.cornerRadius = 5
        badgeLabel.layer.masksToBounds = true
        contentView.addSubview(badgeLabel)
    }
    
    func configure(with book: Book) {
        imageView.image = UIImage(named: book.image)
        imageView.frame = CGRect(x: 0, y: 0, width: bounds.width, height: 100)
        
        titleLabel.text = book.title
        titleLabel.frame = CGRect(x: 0, y: 110, width: bounds.width, height: 20)
        
        if !book.isNew {
            badgeLabel.text = "Новинка"
            badgeLabel.frame = CGRect(x: 0, y: -20, width: 70, height: 20)
            badgeLabel.isHidden = false
        } else {
            badgeLabel.isHidden = true
        }
    }
}

