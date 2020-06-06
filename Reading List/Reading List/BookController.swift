//
//  BookController.swift
//  Reading List
//
//  Created by Peggy Wollenhaupt on 6/6/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import Foundation

class BookController {

    var books: [Book] = []
    
    func createBook(with title: String, reasonToRead: String) -> Book {
        
        let book = Book(title: title, reasonToRead: reasonToRead)
        
        books.append(book)
        saveToPersistentStore()
        return book
        
    }
    
    func deleteBook(with book: Book) {
        
        guard let index = books.firstIndex(of: book) else { return }
        
        books.remove(at: index)
        saveToPersistentStore()
        
    }
    
    func updateHasBeenRead(for book: Book) {
        guard let updated = books.firstIndex(of: book) else { return }
        
        books[updated].hasBeenRead.toggle()
        saveToPersistentStore()
        
    }
    
    func editBook(for book: Book) {
        guard let edited = books.firstIndex(of: book) else { return }
        
        books[edited].title = book.title
        books[edited].reasonToRead = book.reasonToRead
        saveToPersistentStore()
        
    }
    
    
    private var readingListURL: URL? {
        
        let fm = FileManager.default
        
        guard let dir = fm.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        
        return dir.appendingPathComponent("ReadingList.plist")
        
    }
    
    private func saveToPersistentStore() {
        guard let url = readingListURL else { return }
        
        do {
            
            let encoder = PropertyListEncoder()
            let data = try encoder.encode(books)
            try data.write(to: url)
            
        } catch {
            
            print("Unable to encode or write data: \(error)")
            
        }
    }
    
    private func loadFromPersistentStore() {
        
        let fm = FileManager.default
        
        guard let url = readingListURL, fm.fileExists(atPath: url.path) else { return }
        
        do {
            
            let data = try Data(contentsOf: url)
            let decoder = PropertyListDecoder()
            books = try decoder.decode([Book].self, from: data)
            
        } catch {
            
            print("Unable to load data: \(error)")
            
        }
        
    }
}

