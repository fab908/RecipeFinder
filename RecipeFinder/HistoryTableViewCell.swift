//
//  HistoryTableViewCell.swift
//  RecipeFinder
//
//  Created by Fabrizio Grossi on 2023-07-31.
// table view cell for the ingredient history.


import UIKit

class HistoryTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var buttonLabel: UILabel!
    @IBOutlet weak var historyAddButton: UIButton!
    

    @IBOutlet weak var historyDeleteButton: UIButton!
    
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
