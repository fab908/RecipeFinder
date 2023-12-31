//
//  InstructionsTableViewCell.swift
//  RecipeFinder
//
//  Created by Fabrizio Grossi on 2023-08-09.
//  table view cell for the instructions view listing all the instructions for the recipe chosen by the user


import UIKit

class InstructionsTableViewCell: UITableViewCell {

    @IBOutlet weak var InstructionTextView: UITextView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
