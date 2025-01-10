//
//  BookType.swift
//  BookStoreApp
//
//  Created by Полина Соколова on 23.12.24.
//

import Foundation

struct BookType: Hashable {
    let type: String
    let books: [Book]
}

struct Book: Hashable {
    let image: String
    let title: String
    var isNew = false
}
