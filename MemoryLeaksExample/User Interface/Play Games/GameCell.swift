//
//  GameCell.swift
//  MemoryLeaksExample
//
//  Created by Chuck Krutsinger on 2/12/19.
//  Copyright © 2019 Countermind, LLC. All rights reserved.
//

import UIKit

class GameCell: UITableViewCell {
    
    static let id = "GameCell"

    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
