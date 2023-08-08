//
//  RecipeController.swift
//  RecipeFinder
//
//  Created by Fabrizio Grossi on 2023-07-26.
//

import UIKit

class RecipeController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var ingredientsTableView: UITableView!
    @IBOutlet weak var recipeLabel: UILabel!
    @IBOutlet weak var recipeImage: UIImageView!
    var recipeId:Int = 0
    var ingredients:String = ""
    var ingredientsArray:[String] = []
    var recipeTitle:String = ""
    var image:String = ""
    let apiManager = ApiManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        recipeLabel.text = recipeTitle
        apiManager.downloadImage(from: URL(string: image)!, imageView: recipeImage)
        print(ingredients.split(separator: ",").count)
        ingredientsArray = ingredients.components(separatedBy: ",")
        ingredientsTableView.delegate = self
        ingredientsTableView.dataSource = self
        /*let ingredientListVC:IngredientListController = self.storyboard?.instantiateViewController(withIdentifier: "IngredientList") as! IngredientListController
        ingredientListVC.ingredients = ingredientsArray*/

        // Do any additional setup after loading the view.
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ingredientsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tempCell:RecipeIngredientsTableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell") as! RecipeIngredientsTableViewCell
        tempCell.ingredientLabel.text = ingredientsArray[indexPath.row]
        
        //downloadImage(from: URL(string: images[indexPath.row])!, imageView: tempCell.recipeImage)
        return tempCell
    }

}
