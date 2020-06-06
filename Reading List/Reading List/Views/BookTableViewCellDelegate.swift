//
//  BookTableViewCellDelegate.swift
//  Reading List
//
//  Created by Peggy Wollenhaupt on 6/6/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import Foundation

protocol BookTableViewCellDelegate: class {
    func toggleHasBeenRead(for cell: BookTableViewCell)
}
