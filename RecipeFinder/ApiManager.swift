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
    
    init(){
        self.field = ""
        self.returnValue = ""
        self.title = []
        self.images = []
        self.ids = []
        self.ingredients = []
    }
    func getIndividualRecipe(id: String){
        // this url is for the api were using. the ingredients string is passed in to search by ingredients
            let jsonUrlString = "https://api.spoonacular.com/recipes/\(id)/analyzedInstructions?apiKey=c3c5688e12d044979252eeb6c6db26ac"
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
                    var count = 0
                    // getting the recipe title
                    for recipe in json! {
                        // appending the id's
                        self.ids.append(json![count]["id"] as! Int)
                            if let title = recipe["title"] as? String {
                                self.title.append(title)
                            }
                        if let image = recipe["image"] as? String {
                            self.images.append(image)
                        }
                        count += 1
                        }
                } catch {
                    self.returnValue = ""
                }
                
                dispatchGroup.leave()
            }.resume()
            
            dispatchGroup.wait() // This will block the main thread until the data task is completed
    }
    
    func getRecipes(field: String, ingredients: String) {
        // this url is for the api were using. the ingredients string is passed in to search by ingredients
            let jsonUrlString = "https://api.spoonacular.com/recipes/findByIngredients?apiKey=c3c5688e12d044979252eeb6c6db26ac&ingredients=\(ingredients)&number=50"
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
                    self.returnValue = json?[0][field] as? String ?? ""
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
