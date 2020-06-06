//
//  BookDetailViewController.swift
//  Reading List
//
//  Created by Peggy Wollenhaupt on 6/6/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit

class BookDetailViewController: UIViewController {

    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var reasonTextView: UITextView!
    
    var bookController: BookController?
    var book: Book?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()

        // Do any additional setup after loading the view.
    }
    
    func updateViews() {
        if let book = book {
            titleField.text = book.title
            reasonTextView.text = book.reasonToRead
            self.title = book.title
        } else {
            self.title = "Add a new book"
        }
        
    }
    
    @IBAction func saveTapped(_ sender: Any) {
        
        guard let title = titleField.text,
            let reason = reasonTextView.text,
            !title.isEmpty,
            !reason.isEmpty else { return }
        
        if let book = book {
            bookController?.editBook(for: book, newTitle: title, newReason: reason)
        } else {
            bookController?.createBook(with: title, reasonToRead: reason)
        }
        navigationController?.popViewController(animated: true)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
