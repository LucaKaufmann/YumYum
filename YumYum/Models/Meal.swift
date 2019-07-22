//
//  Meal.swift
//  YumYum
//
//  Created by Luca Kaufmann on 27.6.2019.
//  Copyright © 2019 Luca Kaufmann. All rights reserved.
//

import SwiftUI
import RealmSwift

class Meal: Object {
    @objc dynamic var id = UUID().uuidString
    @objc dynamic var name = ""
    let ingredients = LinkingObjects(fromType: Ingredient.self, property: "meal")
    
    convenience init(_ name: String) {
        self.init()
        self.name = name
    }
    
    convenience init(id: String, name: String) {
        self.init()
        self.id = id
        self.name = name
    }
}

//struct Meal: Object, Equatable, Hashable, Codable, Identifiable {
//
//    let id: UUID
//    var name: String
//    var ingredients: [Ingredient]?
//
//    init(name: String, ingredients: [Ingredient]?) {
//        self.id = UUID()
//        self.name = name
//        self.ingredients = ingredients
//    }
//
//    init(id: UUID, name: String, ingredients: [Ingredient]?) {
//        self.id = id
//        self.name = name
//        self.ingredients = ingredients
//    }
//}
