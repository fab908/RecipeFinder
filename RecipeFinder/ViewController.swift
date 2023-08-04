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
            print(indexPath.row)
            // creating an instance of the cell template
            let tempCell:HistoryTableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell") as! HistoryTableViewCell
            // SET MENU OPTIONS HERE:
            //----------------------//
            //tempCell.buttonLabel.text = "Search \(indexPath.row + 1)"
            tempCell.historyButton?.tag = indexPath.row
            
            
            
            let menuItems = searchHistory[indexPath.row]
            
            var menuObjects: [UIAction] = []
            
            for item in menuItems {
                
                let tempItem = UIAction(title: item, image: UIImage(systemName: "arrow.clockwise"), identifier: nil) { (_) in
                     // handle refresh
                }

                menuObjects.insert(tempItem, at: 0)

            }
            
            let menu = UIMenu(title: "", children: menuObjects)
            //return the cell
            tempCell.historyButton?.menu = menu
            tempCell.historyButton?.showsMenuAsPrimaryAction = true
            tempCell.historyButton?.changesSelectionAsPrimaryAction = true
            
            print(menuObjects)
            
            
            
            return tempCell
        }
        
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
    @IBAction func historyButtonOnClick(_ sender: UIButton) {
       // historyTableView.selectRow(at: [IndexPath(row:sender.tag,section:0)], animated: <#T##Bool#>, scrollPosition: <#T##UITableView.ScrollPosition#>)
        print("clicked")
    }
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
        historyTableView.reloadData()
        print(searchHistory)
        // *** need to save search history at this point before the next page loads.
        
        /* try to move to apiManager Class */
        
        //do api for filterByMultiingerdient *done
        var recipyList = filterByIngredient(ingredients: ingredients)
        print("from api function call")
        print(recipyList)
        
        //api call for each recipy to get its cateogry and populate the categories array
        
        
    
        
        // createing an object of the resource details controller
        let recipeCategory = self.storyboard?.instantiateViewController(withIdentifier: "RecipeCategory") as! RecipeCategoryController
        self.navigationController?.pushViewController(recipeCategory, animated: true)
        recipeCategory.ingredients = ingredients
    }
    
    
    
    
    /* API call function section */
    struct Nested: Codable {
        let strMeal, strMealThumb, idMeal: String
    }//end struct
    //declare the root struct for the request data
    struct root: Codable {
        let meals: [Nested]
    }//end struct
    
    //func filterByIngredient(ingredients: [String]) -> [Nested]{
        func filterByIngredient(ingredients: [String]) {
            
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
     //   var returnValue : [String]
    let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
        if (error != nil) {
            print(error as Any)
        }// if theres no error in the request
        else {
            let httpResponse = response as? HTTPURLResponse
            // declare the nested struct for the request data
            

            if let data = data {
                      do {
                          let response = try JSONDecoder().decode(root.self, from: data)
                          //do whatever with the decoded data
                         
                          
                          var i=0
                          let Count = response.meals.count
                          print("# of total Recipies = \(Count)")
                          
                          for recipy in response.meals{
                              i=i+1
                              print("      ---Recipy #\(i)----      ")
                              print(recipy)
                              //returnValue[i] = String(recipy)
                              
                              // need to somehow make this accessible outside the api call. Maybe create a return varible to populate and set that to a gloabal varible at the end of the function?
                              
                              
                          }//end for
                         
                      }//end do
                      catch {
                      }//end catch
                  }//end if let data
        }//end else
    })// end let datatask
        dataTask.resume()
        
      // return returnValue
            
        
        
        
        
    }// end filterByIngredient API call function
    
    
    
    
    
    
    
}// end class



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
