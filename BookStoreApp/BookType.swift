//
//  BookType.swift
//  BookStoreApp
//
//  Created by Полина Соколова on 23.12.24.
//

import Foundation

struct BookType {
    let type: String
    let books: [Book]
}

struct Book {
    let image: String
    let title: String
    var isNew = false
}

