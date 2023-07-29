//
//  ViewController.swift
//  RecipeFinder
//
//  Created by Fabrizio Grossi on 2023-07-26.
//

import UIKit
import Darwin

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet var ingredientsViewController: UIView!
    @IBOutlet weak var ingredientsTableView: UITableView!
    @IBOutlet weak var ingredientsTextField: UITextField!
    var ingredients: [String] = []
    var searchHistory = [[String]]()
    
    
    /*-----------------------On startup---------------------------*/
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        // setting the delegate and dataSource as it wasn't working automatically for some reason
        ingredientsTableView.delegate = self
        ingredientsTableView.dataSource = self
    }
    
    
    
    /*-----------------------Ingredients Table View---------------------------*/
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // getting the amount of ingredients in the view
        return ingredients.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // creating an instance of the cell template
        let tempCell:IngredientsTableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell") as! IngredientsTableViewCell
        // setting the label to the ingredient
        tempCell.ingredientLabel!.text = ingredients[indexPath.row]
        //setting the tag value to the row number in the table view
        tempCell.ingredientButton.tag = indexPath.row
        //return the cell
        return tempCell
        
    }

    
    /*-----------------------Add Ingredients---------------------------*/
    @IBAction func submitOnClick(_ sender: Any){
        // setting the range for the regex
        let range = NSRange(location: 0, length: ingredientsTextField.text!.count)
        // regex pattern to eleminate numbers being inputted
        let regex = try! NSRegularExpression(pattern:"^[A-Za-z ]+$")
        
        // if theres text in the input field AND it doesnt contain any letters
        if(!ingredientsTextField.text!.isEmpty && regex.firstMatch(in: ingredientsTextField.text!, options: [], range: range) != nil){
            ingredients.append(ingredientsTextField.text!.lowercased())
            var uniqueIngredients = Array(Set(ingredients))
            uniqueIngredients.sort()
            ingredients = uniqueIngredients
            ingredientsTextField.backgroundColor = UIColor(red: 0, green: 50, blue: 255, alpha: 1)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                self.ingredientsTextField.backgroundColor = UIColor(red: 255, green: 255, blue: 255, alpha: 1)
            }
        }else{
            ingredientsTextField.backgroundColor = UIColor(red: 255, green: 0, blue: 0, alpha: 1)
            ingredientsTextField.shake(textField: ingredientsTextField)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                self.ingredientsTextField.backgroundColor = UIColor(red: 255, green: 255, blue: 255, alpha: 1)
            }
        }
        
        ingredientsTableView.reloadData()
        ingredientsTextField.text! = ""
    }
    
    /*func displayError() async{
        try await Task.sleep(nanoseconds: UInt64(1 * Double(NSEC_PER_SEC)))
    }
     */
    
    
    /*-----------------------Delete Ingredients---------------------------*/
    @IBAction func ingredientButton(_ sender: UIButton) {
        // delete the row from the array
        ingredients.remove(at: sender.tag)
        // delete the row
        ingredientsTableView.deleteRows(at:[IndexPath(row:sender.tag,section:0)],with:.fade)
        // reload the data
        ingredientsTableView.reloadData()
    }
    
    /*-----------------------Find Recipes Button---------------------------*/
    @IBAction func FindRecipesOnClick(_ sender: Any) {
        // make a set from the ingredient list to remove duplicates
       var ingredientsSet = Set(ingredients)
        // create a boolean to set to true if the record is a subset
        var result = false
        // loop through each record in the search history and check if the current ingredient set is a subset of any of the saved sets
        for record in searchHistory{
            if(ingredientsSet.isSubset(of: record)){
                result = true
            }
        }
        //if there was a match and the current record is a subset do nothing
        if(result){
            
        }//otherwise add the current record to the search history
        else{
            searchHistory.append(ingredients)
        }
                
        // check if the newly added set is a superset of any others - if so remove the subset
        var recordNo = 0
        //loop through the search history and make a set varible of each record.
        for record in searchHistory{
            var recordSet = Set(record)
            // create an iterator to keep track of which record were on in the nested loop that follows
            var iterator = 0
            // loop through the search history again and check if any of the sets are a subset of the record were on in the parent loop.
            for records in searchHistory{
                //if the record is a subset of the parent loops set, remove it
                if(recordSet.isSuperset(of: records) && recordNo != iterator){
                    // if true remove records from array
                    searchHistory.remove(at: iterator)
                }
                iterator += 1
            }
            recordNo += 1
        }
        print(searchHistory)
        // *** need to save search history at this point before the next page loads.
        
        
        
        
        
        
        /* ***Not sure if we still need this??? ***
        ingredients.append(ingredientsTextField.text!.lowercased())
        var uniqueIngredients = Array(Set(ingredients))
        uniqueIngredients.sort()
        searchHistory.append(ingredients)
        print(searchHistory[0]) */
        
        // createing an object of the resource details controller
        //let recipeCategory = self.storyboard?.instantiateViewController(withIdentifier: "RecipeCategory") as! RecipeCategoryController
        //self.navigationController?.pushViewController(recipeCategory, animated: true)
    }
    

}
// extension for shaking the text view when incorrect input is entered
extension UIView {
    func shake(duration timeDuration: Double = 0.07, repeat countRepeat: Float = 3, textField ingredientsTextField: UITextField){
        ingredientsTextField.backgroundColor = UIColor(red: 255, green: 0, blue: 0, alpha: 1)
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = timeDuration
        animation.repeatCount = countRepeat
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: CGPoint(x: self.center.x - 5, y: self.center.y))
        animation.toValue = NSValue(cgPoint: CGPoint(x: self.center.x + 5, y: self.center.y))
        self.layer.add(animation, forKey: "position")
        
        //ingredientsTextField.backgroundColor = UIColor(red: 255, green: 255, blue: 255, alpha: 1)
        
    }
}
