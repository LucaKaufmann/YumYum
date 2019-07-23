//
//  Ingredient.swift
//  YumYum
//
//  Created by Luca Kaufmann on 27.6.2019.
//  Copyright © 2019 Luca Kaufmann. All rights reserved.
//

import SwiftUI
import RealmSwift

@objcMembers class Ingredient: Object, Identifiable {
    enum Property: String {
      case id, name, amount, meal
    }
    dynamic var id = UUID().uuidString
    dynamic var name = ""
    dynamic var amount = 0
    dynamic var meal: Meal?
    
    convenience init(name: String, amount: Int, meal: Meal) {
        self.init()
        self.name = name
        self.amount = amount
        self.meal = meal
    }
    
    override class func primaryKey() -> String? {
           return "id"
       }
}

extension Ingredient {
    static func all(in realm: Realm = try! Realm()) -> Results<Ingredient> {
    return realm.objects(Ingredient.self)
      .sorted(byKeyPath: Ingredient.Property.name.rawValue)
    }
    
    @discardableResult
    static func add(name: String, amount: Int, meal: Meal, in realm: Realm = try! Realm())
      -> Ingredient {
        let item = Ingredient(name: name, amount: amount, meal: meal)
        try! realm.write {
          realm.add(item)
        }
        return item
    }
    
    static func delete(ingredient: Ingredient, in realm: Realm = try! Realm()) {
        try! realm.write {
          realm.delete(ingredient)
        }
    }
    
    static func delete(ingredientId: String, in realm: Realm = try! Realm()) {
        guard let itemToDelete = realm.object(ofType: Ingredient.self, forPrimaryKey: ingredientId) else {
            return
        }
        try! realm.write {
          realm.delete(itemToDelete)
        }
    }
    
    func hardCascadeDeleteProperties() -> [String] {
        return [Property.meal.rawValue]
    }
    
    static func objectExists(id: String, in realm: Realm = try! Realm()) -> Bool {
        return realm.object(ofType: Ingredient.self, forPrimaryKey: id) != nil
    }
}
