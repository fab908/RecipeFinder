//
//  Entity+CoreDataProperties.swift
//  RecipeFinder
//
//  Created by user242507 on 8/11/23.
//
//

import Foundation
import CoreData


extension Entity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Entity> {
        return NSFetchRequest<Entity>(entityName: "Entity")
    }

    @NSManaged public var ingredients: [String]?

}

extension Entity : Identifiable {

}
