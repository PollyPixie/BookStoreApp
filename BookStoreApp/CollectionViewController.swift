//
//  CollectionViewController.swift
//  BookStoreApp
//
//  Created by Полина Соколова on 23.12.24.
//

import UIKit

class CollectionViewController: UIViewController {
    
    var bookManager: IBookTypeManager?
    
    private var bookTypes: [BookType] = []
    private var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
}

// MARK: - Setup View
private extension CollectionViewController {
    func setupView() {
        bookTypes = bookManager?.getBookTypes() ?? []
        
        let layout = createLayout()
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(CustomBookCell.self,  forCellWithReuseIdentifier: "CustomBookCell")
        collectionView.register(
            SectionHeaderView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: SectionHeaderView.reuseIdentifier
        )
        collectionView.backgroundColor = .black
        collectionView.dataSource = self
        view.addSubview(collectionView)
        
        configureCollectionView()
    }
    
    func configureCollectionView() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

// MARK: - Layout Configuration
private extension CollectionViewController {
    func createLayout() -> UICollectionViewLayout {
        UICollectionViewCompositionalLayout { sectionIndex, _ in
            let section = self.bookTypes[sectionIndex]
            return self.createSection(for: section)
        }
    }
    
    func createSection(for section: BookType) -> NSCollectionLayoutSection {
        let item = createItem()
        let group = createGroup(with: item)
        let header = createHeader()
        
        let sectionLayout = NSCollectionLayoutSection(group: group)
        sectionLayout.boundarySupplementaryItems = [header]
        sectionLayout.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 0, bottom: 30, trailing: 0)
        
        if section.type == "Новинки в подписке" || section.type == "Выбор редакции" {
            sectionLayout.orthogonalScrollingBehavior = .continuous
        }
        
        return sectionLayout
    }

    func createItem() -> NSCollectionLayoutItem {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(0.5),
            heightDimension: .fractionalHeight(1.0)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
        return item
    }
    
    func createGroup(with item: NSCollectionLayoutItem) -> NSCollectionLayoutGroup {
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(0.2)
        )
        return NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
    }
    
    func createHeader() -> NSCollectionLayoutBoundarySupplementaryItem {
        let headerSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(0.1)
        )
        return NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top
        )
    }
}

// MARK: - UICollectionViewDataSource
extension CollectionViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        bookTypes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        bookTypes[section].books.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CustomBookCell", for: indexPath) as? CustomBookCell else {
            fatalError("Unable to dequeue CustomBookCell")
        }
        
        let book = bookTypes[indexPath.section].books[indexPath.item]
        cell.configure(with: book)
        
        return cell
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        viewForSupplementaryElementOfKind kind: String,
        at indexPath: IndexPath
    ) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let header = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: SectionHeaderView.reuseIdentifier,
                for: indexPath
            ) as! SectionHeaderView
            
            let sectionTitle = bookTypes[indexPath.section].type
            header.configure(text: sectionTitle)
            return header
        }
        return UICollectionReusableView()
    }
}
