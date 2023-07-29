//
//  ViewController.swift
//  RecipeFinder
//
//  Created by Fabrizio Grossi on 2023-07-26.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    @IBAction func FindRecipesOnClick(_ sender: Any) {
        // createing an object of the resource details controller
        let recipeCategory = self.storyboard?.instantiateViewController(withIdentifier: "RecipeCategory") as! RecipeCategoryController
        self.navigationController?.pushViewController(recipeCategory, animated: true)
    }
    

}

