//
//  SearchHistory+CoreDataProperties.swift
//  RecipeFinder
//
//  Created by user242507 on 8/11/23.
//
//

import Foundation
import CoreData


extension SearchHistory {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SearchHistory> {
        return NSFetchRequest<SearchHistory>(entityName: "SearchHistory")
    }

    @NSManaged public var ingredients: [String]?

}

extension SearchHistory : Identifiable {

}
