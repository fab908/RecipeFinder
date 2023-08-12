//
//  ViewController.swift
//  RecipeFinder
//
//  Created by Fabrizio Grossi on 2023-07-26.
//

import UIKit
import Darwin

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var historyTableView: UITableView!
    @IBOutlet var ingredientsViewController: UIView!
    @IBOutlet weak var ingredientsTableView: UITableView!
    @IBOutlet weak var ingredientsTextField: UITextField!
    
    var ingredients: [String] = []
    var searchHistory = [[String]]()
    var apiManager = ApiManager()
    
    /*-----------------------On startup---------------------------*/
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        // setting the delegate and dataSource as it wasn't working automatically for some reason
        ingredientsTableView.delegate = self
        ingredientsTableView.dataSource = self
        historyTableView.delegate = self
        historyTableView.dataSource = self
        
    }
    
    /*func tableView(_ tableView: UITableView, contextMenuConfigurationForRowAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
     
     }*/
    
    /*----------------------- Table View setup---------------------------*/
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // getting the amount of ingredients in the view
        if(tableView == ingredientsTableView){
            return ingredients.count
        }else{
            return searchHistory.count
        }
        
    }
    
    @objc func menuItemAction() {
        // Code to be executed when the menu item is selected
        // For example, show an alert, perform an action, etc.
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(tableView == ingredientsTableView){
            // creating an instance of the cell template
            let tempCell:IngredientsTableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell") as! IngredientsTableViewCell
            // setting the label to the ingredient
            tempCell.ingredientLabel!.text = ingredients[indexPath.row]
            //setting the tag value to the row number in the table view
            tempCell.ingredientButton.tag = indexPath.row
            //return the cell
            return tempCell
        }else{
            //print(indexPath.row)
            // creating an instance of the cell template
            let tempCell:HistoryTableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell") as! HistoryTableViewCell
            // SET MENU OPTIONS HERE:
            //----------------------//
            //tempCell.buttonLabel.text = "Search \(indexPath.row + 1)"
            tempCell.historyAddButton.tag =  indexPath.row
            var tempList : String = ""
            for ingredient in searchHistory[indexPath.row]{
                if(tempList == ""){
                    tempList = "\(ingredient)"
                    
                }
                else{
                    tempList = tempList + ", \(ingredient)"
                }
            }
            tempCell.buttonLabel.text = "\(tempList)"
            
            return tempCell
        }
        
    }
    
    @IBAction func historyButtonClick(_ sender: UIButton) {
        ingredients.removeAll()
        print(sender.tag)
        ingredients = searchHistory[sender.tag]
        ingredientsTableView.reloadData()
        
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
    
    /*-----------------------Clicking a search history button---------------------------*/
    
    
    
    
    
    
    
    
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
    @IBAction func FindRecipesOnClick(_ sender: Any){
        // make a set from the ingredient list to remove duplicates
        let ingredientsSet = Set(ingredients)
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
            let recordSet = Set(record)
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
        historyTableView.reloadData()
        //print(searchHistory)
        // *** need to save search history at this point before the next page loads.
        
        /* try to move to apiManager Class */
        
        //do api for filterByMultiingerdient *done
        /*var recipyList = */
        // anonumous function to convert the Array of ingredients [String] To a comma seperated list
        // end anonumous function
        //api call for each recipy to get its cateogry and populate the categories array
        
        apiManager.getRecipes(ingredients: apiManager.IngredientsPrep(ingredients: ingredients))
        let recipesView = self.storyboard?.instantiateViewController(withIdentifier: "RecipesView") as! RecipesController
        self.navigationController?.pushViewController(recipesView, animated: true)
        recipesView.recipeTitles = apiManager.title
        recipesView.images = apiManager.images
        recipesView.recipeIds = apiManager.ids
        recipesView.ingredients = apiManager.ingredients
        
        
    }
    
    
    
    

    
    
    
    
    
    //old code for original API call
    
    //structs for filterbyIngerdients API call
    struct Nested: Codable {
        let idMeal, strMeal, strMealThumb: String
    }//end struct
    struct NestedAlt: Codable {
        let idMeal, strMeal, strMealThumb: String?
        let strCategory: String
        let strDrinkAlternate, strArea, strInstructions, strTags, strYoutube: String?
        let strIngredient1, strIngredient2, strIngredient3, strIngredient4, strIngredient5, strIngredient6, strIngredient7, strIngredient8, strIngredient9, strIngredient10, strIngredient11, strIngredient12, strIngredient13, strIngredient14, strIngredient15, strIngredient16, strIngredient17, strIngredient18, strIngredient19, strIngredient20: String?
        let strMeasure1, strMeasure2, strMeasure3, strMeasure4, strMeasure5, strMeasure6, strMeasure7, strMeasure8, strMeasure9, strMeasure10, strMeasure11, strMeasure12, strMeasure13, strMeasure14, strMeasure15, strMeasure16, strMeasure17, strMeasure18, strMeasure19, strMeasure20: String?
    }//end struct    //declare the root struct for the request data
    struct root: Codable {
        var meals: [Nested]
    }//end struct
    struct rootAlt: Codable {
        var meals: [NestedAlt]
    }//end struct
    
    
    // recipy lookup API function
       
    
    @MainActor
    func recipyLookup(recipyId: Int32, completion: @escaping (rootAlt) -> Void) {
        
        let headers = [
            "X-RapidAPI-Key": "14fc04b22fmsh316f7bb4d82555dp166249jsn7a012b0bd69e",
            "X-RapidAPI-Host": "themealdb.p.rapidapi.com"
        ]
        
        let request = NSMutableURLRequest(url: NSURL(string: "https://themealdb.p.rapidapi.com/lookup.php?i=\(recipyId)")! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        let session = URLSession.shared
      
        
        let dataTask = session.dataTask(with: request as URLRequest) { data, response, error in
                if let error = error {
                    print(error as Any)
                    completion(rootAlt(meals: []))
                    return
                }
                
                if let data = data {
                    do {
                        let response = try JSONDecoder().decode(rootAlt.self, from: data)
                        completion(response)
                    } catch {
                        print(error)
                        completion(rootAlt(meals: []))
                    }
                } else {
                    completion(rootAlt(meals: []))
                }
            }
            
            dataTask.resume()
    }
    //func filterByIngredient(ingredients: [String]) -> [root]{
    @MainActor
    func filterByIngredient(ingredients: [String], completion: @escaping ([Int]) -> Void) {
        
        // anonumous function to convert the Array of ingredients [String] To a comma seperated list
        func cslIngerdients(ingredients: [String]) -> String
        {
            //declare&initalise a return varible
            var returnValue = ""
            //declare and initalise a counter
            var i = 0
            //loop through each ingredient in the ingredients array passed to the function
            for ingredient in ingredients {
                //replace any spaces with underscores for api compatibility
                var escapedIngredient = ingredient.replacingOccurrences(of: " ", with: "_")
                //increment iterator
                i = i + 1
                //if were on first iteration dont add a comma
                if(i==1){
                    returnValue = returnValue     + "\(escapedIngredient)"
                }// otherwise add the comma
                else{
                    returnValue = returnValue     + ",\(escapedIngredient)"
                }
            }// end for
            // return the return value after loop completion
            return returnValue
        }// end anonumous function
        
        // declare headers for API call
        let headers = [
            "X-RapidAPI-Key": "34b3adc60fmsh158723caa37e992p123c89jsnf450fd015e4b",
            "X-RapidAPI-Host": "themealdb.p.rapidapi.com",
            "Content-Type":    "application/json"   ]
        // API REquest stuff
        let request = NSMutableURLRequest(url: NSURL(string: "https://themealdb.p.rapidapi.com/filter.php?i=\(cslIngerdients(ingredients: ingredients))")! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        let session = URLSession.shared
        // working with the request data
        
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if (error != nil) {
                print(error as Any)
            }// if theres no error in the request
            else {
                let httpResponse = response as? HTTPURLResponse
                // declare the nested struct for the request data
                
                
                if let data = data {
                    var returnValue: [Int] = []
                    
                    do {
                        let response = try JSONDecoder().decode(root.self, from: data)
                        
                        var i = 0
                        for recipy in response.meals {
                            if let idMeal = Int(recipy.idMeal) {
                                returnValue.append(idMeal)
                            }
                            i += 1
                        }
                        
                    } catch {
                        print(error)
                    }
                    //end catch
                    // Call the completion handler with the extracted values
                    completion(returnValue)
                    
                }//end if let data
                
                
            }//end else
        })// end let datatask
        dataTask.resume()
        
        // return returnValue
        
        
        
        
        
    }// end filterByIngredient API call function
    
    
    
    
    
}// end class
// end of old API call


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
