/*
 RecipeInstructionsController.swift
 RecipeFinder
 Created by Kyle Duffy on 2023-07-26.
 description:
 This View will populate the instructions needed to complete the recipe selected from the api. You are given an option to see the ingredients, as well as go back to the recipe description.
*/


import UIKit

class RecipeInstructionsController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var recipeId:String = ""
    var steps:[String] = []
    let apiManager = ApiManager()

    @IBOutlet weak var stepsTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        apiManager.getRecipeInformation(id: recipeId)
        steps = apiManager.steps
        stepsTableView.dataSource = self
        stepsTableView.delegate = self
        
        // Do any additional setup after loading the view.
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return steps.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tempCell:InstructionsTableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell") as! InstructionsTableViewCell
        tempCell.InstructionTextView.text = steps[indexPath.row]
        return tempCell
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
