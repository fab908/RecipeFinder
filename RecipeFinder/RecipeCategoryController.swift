//
//  RecipeCategoryController.swift
//  RecipeFinder
//
//  Created by Fabrizio Grossi on 2023-07-26.
//

import UIKit

class RecipeCategoryController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func nextView(_ sender: Any) {
        // createing an object of the resource details controller
        let recipesView = self.storyboard?.instantiateViewController(withIdentifier: "RecipesView") as! RecipesController
        self.navigationController?.pushViewController(recipesView, animated: true)
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
