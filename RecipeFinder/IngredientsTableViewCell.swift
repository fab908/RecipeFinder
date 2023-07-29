//
//  IngredientsTableViewCell.swift
//  RecipeFinder
//
//  Created by Fabrizio Grossi on 2023-07-29.
//

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
