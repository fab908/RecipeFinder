//
//  IngredientListViewController.swift
//  RecipeFinder
//
//  Created by Fabrizio Grossi on 2023-08-07.
//

import UIKit

class IngredientListController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var ingredientsTableView: UITableView!
    var ingredients:[String] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        ingredientsTableView.dataSource = self
        ingredientsTableView.delegate = self
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ingredients.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tempCell:RecipeIngredientsTableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell") as! RecipeIngredientsTableViewCell
        tempCell.ingredientLabel.text = ingredients[indexPath.row]
        
        //downloadImage(from: URL(string: images[indexPath.row])!, imageView: tempCell.recipeImage)
        return tempCell
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
