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
    
    private var diffableDataSource: UICollectionViewDiffableDataSource<BookType, Book>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        loadData()
        setupDataSource()
        applySnapshot()
    }
}

// MARK: - Setup View
private extension CollectionViewController {
    func setupView() {
        let layout = createLayout()
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(CustomBookCell.self,  forCellWithReuseIdentifier: "CustomBookCell")
        collectionView.register(
            SectionHeaderView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: SectionHeaderView.reuseIdentifier
        )
        collectionView.backgroundColor = .black
        view.addSubview(collectionView)
        
        configureCollectionView()
    }
    
    func loadData() {
        bookTypes = bookManager?.getBookTypes() ?? []
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

// MARK: - DiffableDataSource
private extension CollectionViewController {
    func setupDataSource() {
        diffableDataSource = UICollectionViewDiffableDataSource<BookType, Book>(
            collectionView: collectionView,
            cellProvider: { (collectionView, indexPath, book) -> UICollectionViewCell? in
                guard let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: "CustomBookCell",
                    for: indexPath
                ) as? CustomBookCell else {
                    return nil
                }
                cell.configure(with: book)
                return cell
            }
        )
        
        diffableDataSource?.supplementaryViewProvider = { (collectionView, kind, indexPath) -> UICollectionReusableView? in
            if kind == UICollectionView.elementKindSectionHeader {
                guard let header = collectionView.dequeueReusableSupplementaryView(
                    ofKind: kind,
                    withReuseIdentifier: SectionHeaderView.reuseIdentifier,
                    for: indexPath
                ) as? SectionHeaderView else {
                    return nil
                }
                let sectionTitle = self.diffableDataSource?.snapshot().sectionIdentifiers[indexPath.section].type
                header.configure(text: sectionTitle ?? "")
                return header
            }
            return nil
        }
    }
    
    func applySnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<BookType, Book>()
        snapshot.appendSections(bookTypes)
        for bookType in bookTypes {
            snapshot.appendItems(bookType.books, toSection: bookType)
        }
        diffableDataSource?.apply(snapshot, animatingDifferences: true)
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
