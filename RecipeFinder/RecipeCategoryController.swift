/*
 RecipesController.swift
 RecipeFinder
 Created by Fabrizio Grossi on 2023-07-26.
 description:
 This is when you press find ingredients, a this page will implement the api to look for recipes with the ingredient list
 and produce an image, and title of the recipe. When clicked it will move on to the next view.
*/

import UIKit

class RecipeCategoryController: UIViewController {
    var ingredients: [String] = []
    var recipeCategories: [String] = []
   // var fullRecipeList: [rootAlt] = []
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        print("from category veiw controller \(recipeCategories)")
    }
    
    @IBAction func nextView(_ sender: Any) {
        // createing an object of the resource details controller
        let recipesView = self.storyboard?.instantiateViewController(withIdentifier: "RecipesView") as! RecipesController
        self.navigationController?.pushViewController(recipesView, animated: true)
    }
    
    

}
