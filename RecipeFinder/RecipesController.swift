//
//  RecipesController.swift
//  RecipeFinder
//
//  Created by Fabrizio Grossi on 2023-07-26.
//

import UIKit

class RecipesController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    
    @IBOutlet weak var recipesTableView: UITableView!
    var recipeTitles:[String] = []
    var images:[String] = []
    var recipeIds:[Int] = []
    var ingredients:[String] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        recipesTableView.dataSource = self
        recipesTableView.delegate = self
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipeTitles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tempCell:RecipesTableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell") as! RecipesTableViewCell
        tempCell.recipeTitleTextField!.text = String(recipeTitles[indexPath.row])
        Task{
            tempCell.recipeImage.image = loadImage(images[indexPath.row])
        }
        
        //downloadImage(from: URL(string: images[indexPath.row])!, imageView: tempCell.recipeImage)
        return tempCell
    }
    
    // going to the next view controller to display more information on the row clicked
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // creating a new object for the controller
        let detailVC:RecipeController = self.storyboard?.instantiateViewController(withIdentifier: "RecipeView") as! RecipeController
       // assign the values to the local variable declared in MovieDetailController Class
        detailVC.recipeId = recipeIds[indexPath.row]
        detailVC.ingredients = ingredients[indexPath.row]
        detailVC.recipeTitle = recipeTitles[indexPath.row]
        detailVC.image = images[indexPath.row]
        // make it navigate to ProductDetailViewController
        self.navigationController?.pushViewController(detailVC, animated: true)
        //performSegue(withIdentifier: "TabBarController", sender: self)
    }
    
    @IBAction func nextView(_ sender: Any) {
        // createing an object of the resource details controller
        let recipeView = self.storyboard?.instantiateViewController(withIdentifier: "RecipeView") as! RecipeController
        self.navigationController?.pushViewController(recipeView, animated: true)
    }
    
    @IBAction func homeOnClick(_ sender: Any) {
        // createing an object of the resource details controller
        let homeView = self.storyboard?.instantiateViewController(withIdentifier: "HomePage") as! ViewController
        self.navigationController?.pushViewController(homeView, animated: true)
    }
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    func downloadImage(from url: URL, imageView: UIImageView) {
          getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            print(response?.suggestedFilename ?? url.lastPathComponent)

            // always update the UI from the main thread
            DispatchQueue.main.async() { [weak self] in
                imageView.image = UIImage(data: data)
            }
        }
    }
    
    func loadImage(_ link: String) -> UIImage{
        do{
            guard let url = URL(string: link)else{
                return UIImage()
            }
            let data:Data = try Data(contentsOf: url)
            return UIImage(data: data) ?? UIImage()
        }catch{
            
        }
        return UIImage()
    }
}
    
