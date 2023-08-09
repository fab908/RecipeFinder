//
//  ApiManager.swift
//  RecipeFinder
//
//  Created by Fabrizio Grossi on 2023-08-03.
//

import Foundation
import UIKit
class ApiManager{
    var field: String
    var returnValue: String
    var title: [String]
    var images: [String]
    var ids:[Int]
    var ingredients:[String]
    var steps:[String]
    var recipeDescription:String
    var apiKey:String = "6dd6de4a454a4313a66c2d1f0124abf7"
    init(){
        self.field = ""
        self.returnValue = ""
        self.title = []
        self.images = []
        self.ids = []
        self.ingredients = []
        self.steps = []
        self.recipeDescription = ""
    }

    
    func getRecipeInformation(id: String){
        // this url is for the api were using. the ingredients string is passed in to search by ingredients
        //
        //https://api.spoonacular.com/recipes/informationBulk?apiKey=6dd6de4a454a4313a66c2d1f0124abf7&ids=1697601
            let jsonUrlString = "https://api.spoonacular.com/recipes/informationBulk?apiKey=\(apiKey)&ids=\(id)"
        // switching it to a url object. if it doesnt pass or its a bad url it will return nothing
            guard let url = URL(string: jsonUrlString) else {
                return
            }
            // this will allow us to wait until this call is completely done to set our values to the local variables so
        // we can have access to it wherever we need it
            let dispatchGroup = DispatchGroup()
        // starting the dispatch group
            dispatchGroup.enter()
            // creating the request to the api.
        // data = the data we will be receiving, response = https resonse(200 means it succeeded), error = error message
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                // making sure we got data.
                guard let data = data else { return }
                do {
                    // make our data a json object so we can pull the values
                    let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [[String: Any]]
                    /*for ingredient in json![0]["missedIngredients"] as? [[String: Any]] ?? [] {
                            if let name = ingredient["original"] as? String {
                                print("Ingredient Name:", name)
                            }
                        }*/

                    
                    for recipe in json! {
                        // getting the recipe ingredients
                        if let ingredients = recipe["extendedIngredients"] as? [[String: Any]] {
                            for ingredient in ingredients {
                                if let original = ingredient["original"] as? String {
                                    self.ingredients.append(original)
                                }
                            }
                        }
                        // getting the recipe instructions
                        // putting the "analyzedInstructions" section of the json into an md array
                        for instruction in recipe["analyzedInstructions"] as? [[String: Any]] ?? []{
                            for step in instruction["steps"]as? [[String: Any]] ?? []{
                                self.steps.append(step["step"]! as! String)
                                
                            }
                            
                        }
                            
                            
                            
                            /*for steps in instructions[0]["steps"] as? [[String: Any]] ?? [] {
                                for step in steps["step"] as? [[String: Any]] ?? [] {
                                    print(step)
                                    print("-------------End of Steps-------------")
                                }
                            }*/
                        
                               // putting the "steps" section of the "analyzedInstruction" section of the json into an md array
                           
                              /* let stepsArray = instructions.first?["steps"] as? [[String: Any]] {
                                // looping through the md array
                                for stepInfo in stepsArray {
                                    // looking for the "step" section that holds all the steps in the recipe and storing it as a string
                                    if let step = stepInfo["step"] as? String {
                                        // separating the steps by the periods into an array so that
                                        // We could make a numbered list of steps
                                        self.steps = step.components(separatedBy: ".")
                                        print(self.steps)
                                        
                                    }
                                }
                            }*/
                        //getting the recipe description and storing it into the variable
                        self.recipeDescription = recipe["summary"] as! String

                        // Defining a regular expression pattern to match HTML tags since the response contains them.
                        let htmlTagPattern = "<[^>]+>"

                        // Use the regular expression to replace HTML tags with an empty string
                        self.recipeDescription = self.recipeDescription.replacingOccurrences(
                            of: htmlTagPattern,
                            with: "",
                            options: .regularExpression,
                            range: nil
                        )
                    }
                    
                    
                    
                    
                        
                } catch {
                    self.returnValue = ""
                }
                
                dispatchGroup.leave()
            }.resume()
            
            dispatchGroup.wait() // This will block the main thread until the data task is completed
    }
    
    func getRecipes(ingredients: String) {
        // this url is for the api were using. the ingredients string is passed in to search by ingredients
        let jsonUrlString = "https://api.spoonacular.com/recipes/findByIngredients?apiKey=\(apiKey)&ingredients=\(ingredients)&number=50"
        // switching it to a url object. if it doesnt pass or its a bad url it will return nothing
            guard let url = URL(string: jsonUrlString) else {
                return
            }
            // this will allow us to wait until this call is completely done to set our values to the local variables so
        // we can have access to it wherever we need it
            let dispatchGroup = DispatchGroup()
        // starting the dispatch group
            dispatchGroup.enter()
            // creating the request to the api.
        // data = the data we will be receiving, response = https resonse(200 means it succeeded), error = error message
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                // making sure we got data.
                guard let data = data else { return }
                do {
                    // make our data a json object so we can pull the values
                    let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [[String: Any]]
                    print(json)
                    // getting the ingredients for the recipe
                    /*for ingredient in json![1]["usedIngredients"] as? [[String: Any]] ?? [] {
                            if let name = ingredient["original"] as? String {
                                print("Ingredient Name:", name)
                            }
                        }
                    for ingredient in json![1]["missedIngredients"] as? [[String: Any]] ?? [] {
                            if let name = ingredient["original"] as? String {
                                print("Ingredient Name:", name)
                            }
                        }*/
                    var count = 0
                    // getting the recipe title
                    for recipe in json! {
                        // appending the id's
                        self.ids.append(json![count]["id"] as! Int)
                            if let title = recipe["title"] as? String {
                                self.title.append(title)
                            }
                        // appending the images
                        if let image = recipe["image"] as? String {
                            self.images.append(image)
                        }
                        var ingredientPrep:String = ""
                        for ingredient in json![count]["missedIngredients"] as? [[String: Any]] ?? [] {
                            if var name = ingredient["original"] as? String {
                                name = name.replacingOccurrences(of: ",", with: "")
                                ingredientPrep = ingredientPrep + "\(name),"
                            }
                        }
                        for ingredient in json![count]["usedIngredients"] as? [[String: Any]] ?? [] {
                            if var name = ingredient["original"] as? String {
                                name = name.replacingOccurrences(of: ",", with: "")
                                ingredientPrep = ingredientPrep + "\(name),"
                            }
                        }
                        self.ingredients.append(ingredientPrep)
                        print(ingredientPrep)
                        count += 1
                        
                        
                        }
                } catch {
                    self.returnValue = ""
                }
                
                dispatchGroup.leave()
            }.resume()
            
            dispatchGroup.wait() // This will block the main thread until the data task is completed
        }
    
    func IngredientsPrep(ingredients: [String]) -> String
    {
        //declare&initalise a return varible
        var returnValue = ""
        //declare and initalise a counter
        var i = 0
        //loop through each ingredient in the ingredients array passed to the function
        for ingredient in ingredients {
            //replace any spaces with underscores for api compatibility
            //var escapedIngredient = ingredient.replacingOccurrences(of: " ", with: seperator)
            //increment iterator
            i = i + 1
            //if were on first iteration dont add a comma
            if(i==1){
                returnValue = returnValue     + ingredient
            }// otherwise add the comma
            else{
                returnValue = returnValue     + ",+\(ingredient)"
            }
        }// end for
        // return the return value after loop completion
        return returnValue
    }
    
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    func downloadImage(from url: URL, imageView: UIImageView) {
        // getting the data using the function above and using an async to get download the photos from the url
          getData(from: url) { data, response, error in
              // making sure the data contains the image
            guard let data = data, error == nil else { return }
            // always update the UI from the main thread
            // using an async dispatch queue so that the app doesnt lag
            DispatchQueue.main.async() { [weak self] in
                // setting the imageViews image set in the function call to the data (the image) that was sent back in the api call
                imageView.image = UIImage(data: data)
            }
        }
    }
                                      
}
