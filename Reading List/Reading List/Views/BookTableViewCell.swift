//
//  BookTableViewCell.swift
//  Reading List
//
//  Created by Peggy Wollenhaupt on 6/6/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit

class BookTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var readButton: UIButton!
    
    var book: Book? {
        didSet {
            updateViews()
        }
    }
    
    weak var delegate: BookTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBAction func readButtonTapped(_ sender: UIButton) {
        
        delegate?.toggleHasBeenRead(for: self)
        updateViews()
        
    }
    
    func updateViews() {
        if let book = book {
            titleLabel.text = book.title
        }
        
        if book?.hasBeenRead == true  {
            readButton.setImage(#imageLiteral(resourceName: "checked"), for: .normal)
        } else {
            readButton.setImage(#imageLiteral(resourceName: "unchecked"), for: .normal)
        }
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
