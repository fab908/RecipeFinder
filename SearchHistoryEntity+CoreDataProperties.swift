//
//  SearchHistoryEntity+CoreDataProperties.swift
//  RecipeFinder
//
//  Created by user242507 on 8/11/23.
//
//

import Foundation
import CoreData


extension SearchHistoryEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SearchHistoryEntity> {
        return NSFetchRequest<SearchHistoryEntity>(entityName: "SearchHistoryEntity")
    }

    @NSManaged public var ingredientList: [[String]]?

}

extension SearchHistoryEntity : Identifiable {

}
