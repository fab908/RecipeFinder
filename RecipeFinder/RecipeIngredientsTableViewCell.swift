//
//  RecipeIngredientsTableViewCell.swift
//  RecipeFinder
//
//  Created by Fabrizio Grossi on 2023-08-07.
//

import UIKit

class RecipeIngredientsTableViewCell: UITableViewCell {

    @IBOutlet weak var ingredientLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
