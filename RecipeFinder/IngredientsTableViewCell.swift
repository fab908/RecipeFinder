//
//  IngredientsTableViewCell.swift
//  RecipeFinder
//
//  Created by Kyle Duffy on 2023-07-29.
// table view cell for the ingredients view listing all the ingredients for the recipe chosen by the user


import UIKit

class IngredientsTableViewCell: UITableViewCell {
    

    @IBOutlet weak var ingredientButton: UIButton!
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
