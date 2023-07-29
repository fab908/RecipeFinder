//
//  ViewController.swift
//  RecipeFinder
//
//  Created by Fabrizio Grossi on 2023-07-26.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var ingredientsTableView: UITableView!
    @IBOutlet weak var ingredientsTextField: UITextField!
    var ingredients: [String] = ["A", "B"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        // setting the delegate and dataSource as it wasn't working automatically for some reason
        ingredientsTableView.delegate = self
        ingredientsTableView.dataSource = self
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ingredients.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tempCell:IngredientsTableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell") as! IngredientsTableViewCell
        tempCell.ingredientButton.titleLabel!.text = ingredients[indexPath.row]
        return tempCell
        
    }


    
    
    
    
    
    @IBAction func submitOnClick(_ sender: Any) {
        if(!ingredientsTextField.text!.isEmpty){
            
        }
    }
    
    
    
    
    
    
    
    
    
    @IBAction func FindRecipesOnClick(_ sender: Any) {
        // createing an object of the resource details controller
        let recipeCategory = self.storyboard?.instantiateViewController(withIdentifier: "RecipeCategory") as! RecipeCategoryController
        self.navigationController?.pushViewController(recipeCategory, animated: true)
    }
    

}

