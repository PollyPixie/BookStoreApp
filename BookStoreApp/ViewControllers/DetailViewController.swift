//
//  DetailViewController.swift
//  BookStoreApp
//
//  Created by Полина Соколова on 10.01.25.
//

import UIKit

class DetailViewController: UIViewController {
    
    var book: Book?
    
    private let imageView = UIImageView()
    private let titleLabel = UILabel()
    private var isFavorite = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        configureWithBook()
        setupNavigationBar()
    }
    
    private func configureWithBook() {
        guard let book = book else { return }
        imageView.image = UIImage(named: book.image)
        titleLabel.text = book.title
    }
}
    
// MARK: - Setup View
private extension DetailViewController {
    func setupView() {
        view.backgroundColor = .black
        
        imageView.contentMode = .scaleAspectFit
        view.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        titleLabel.textColor = .white
        titleLabel.font = UIFont.boldSystemFont(ofSize: 24)
        titleLabel.textAlignment = .center
        view.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            imageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.4),
            
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
    }
}
    
// MARK: - Setup Navigation Bar
private extension DetailViewController {
    func setupNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = false
        
        let titleLabel = UILabel()
        titleLabel.text = "Book"
        titleLabel.textColor = .white
        titleLabel.font = UIFont.boldSystemFont(ofSize: 18)
        navigationItem.titleView = titleLabel
        
        let favoriteButton = UIBarButtonItem(
            image: UIImage(systemName: "heart"),
            style: .plain,
            target: self,
            action: #selector(favoriteButtonTapped)
        )
        
        navigationItem.rightBarButtonItem = favoriteButton
    }
    
    @objc private func favoriteButtonTapped() {
        isFavorite.toggle()
        let imageName = isFavorite ? "heart.fill" : "heart"
        navigationItem.rightBarButtonItem?.image = UIImage(systemName: imageName)
        navigationItem.rightBarButtonItem?.tintColor = isFavorite ? .red : .white
    }
}

