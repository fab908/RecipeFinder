//
//  HistoryTableViewCell.swift
//  RecipeFinder
//
//  Created by Fabrizio Grossi on 2023-07-31.
//

import UIKit

class HistoryTableViewCell: UITableViewCell {

    @IBOutlet weak var historyButton: UIButton!
    @IBOutlet weak var historyButtonMenu: UIMenu!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}