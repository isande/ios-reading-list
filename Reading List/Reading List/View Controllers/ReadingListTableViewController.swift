//
//  ReadingListTableViewController.swift
//  Reading List
//
//  Created by Peggy Wollenhaupt on 6/6/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit

class ReadingListTableViewController: UITableViewController {

    let bookController = BookController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.reloadData()
        bookController.loadFromPersistentStore()

    }

    override func viewDidAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if section == 0 {
            return bookController.unreadBooks.count
        } else if section == 1 {
            return bookController.readBooks.count
        } else {
            return 0
        }
    }

    private func bookFor(indexPath: IndexPath) -> Book {
        if indexPath.section == 0 {
            return bookController.unreadBooks[indexPath.row]
        } else {
            return bookController.readBooks[indexPath.row]
        }
    }
    
    

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "BookCell", for: indexPath) as? BookTableViewCell else { return UITableViewCell() }
        cell.delegate = self
        let book = bookFor(indexPath: indexPath)
        cell.book = book

        return cell
    }


    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */


    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let book = bookFor(indexPath: indexPath)
            bookController.deleteBook(with: book)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Unread Books"
        } else if section == 1 {
            return "Read Books"
        } else {
            return ""
        }
    }
    
    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showBookDetail" {
            
            if let bookDetailVC = segue.destination as? BookDetailViewController {
                if let indexPath = tableView.indexPathForSelectedRow {
                    let book = bookFor(indexPath: indexPath)
                    bookDetailVC.bookController = bookController
                    bookDetailVC.book = book
                }
            }
            
        } else if segue.identifier == "showAddBook" {
            if let newBookVC = segue.destination as? BookDetailViewController {
                newBookVC.bookController = bookController
            }
        }
    }
    
}

extension ReadingListTableViewController: BookTableViewCellDelegate {
    func toggleHasBeenRead(for cell: BookTableViewCell) {
        if let indexPath = tableView.indexPath(for: cell) {
            let book = bookFor(indexPath: indexPath)
            bookController.updateHasBeenRead(for: book)
            tableView.reloadData()
        }
    }
}
