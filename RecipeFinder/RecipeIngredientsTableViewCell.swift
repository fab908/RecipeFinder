//
//  RecipeIngredientsTableViewCell.swift
//  RecipeFinder
//
//  Created by Kyle Duffy on 2023-08-07.
//  table view cell for the ingredients


import UIKit

class RecipeIngredientsTableViewCell: UITableViewCell {

    @IBOutlet weak var ingredientsTextView: UITextView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
