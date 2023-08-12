//
//  SearchHistory+CoreDataClass.swift
//  RecipeFinder
//
//  Created by user242507 on 8/11/23.
//
//

import Foundation
import CoreData

@objc(SearchHistory)
public class SearchHistory: NSManagedObject {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        // setting the delegate and dataSource as it wasn't working automatically for some reason
        ingredientsTableView.delegate = self
        ingredientsTableView.dataSource = self
        historyTableView.delegate = self
        historyTableView.dataSource = self
        
    }
}
