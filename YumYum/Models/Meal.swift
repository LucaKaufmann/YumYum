//
//  Meal.swift
//  YumYum
//
//  Created by Luca Kaufmann on 27.6.2019.
//  Copyright © 2019 Luca Kaufmann. All rights reserved.
//

import SwiftUI
import RealmSwift

class Meal: Object, Identifiable {
    enum Property: String {
      case id, name
    }
    @objc dynamic var id = UUID().uuidString
    @objc dynamic var name = ""

    let ingredients = RealmSwift.List<Ingredient>()
    
    convenience init(_ name: String) {
        self.init()
        self.name = name
    }
    
    convenience init(id: String, name: String) {
        self.init()
        self.id = id
        self.name = name
    }
    
    override class func primaryKey() -> String? {
           return "id"
       }
    
    func addIngredient(name: String, amount: Int, in realm: Realm = try! Realm()) {
        let ingredient = Ingredient.add(name: name, amount: amount, meal: self)
        try! realm.write {
            self.ingredients.append(ingredient)
        }
    
//        let item = Meal(name)
//        try! realm.write {
//          realm.add(item)
//        }
    }
    
    func deleteIngredient(ingredient: Ingredient, in realm: Realm = try! Realm()) {
        Ingredient.delete(ingredient: ingredient)
        try! realm.write {
            if let index = self.ingredients.index(of: ingredient) {
                self.ingredients.remove(at: index)
            }
        }
    }
}

extension Meal {
    static func all(in realm: Realm = try! Realm()) -> Results<Meal> {
    return realm.objects(Meal.self)
      .sorted(byKeyPath: Meal.Property.name.rawValue)
    }
    
    @discardableResult
    static func add(name: String, in realm: Realm = try! Realm())
      -> Meal {
        let item = Meal(name)
        try! realm.write {
          realm.add(item)
        }
        return item
    }
    
    static func delete(meal: Meal, in realm: Realm = try! Realm()) {
        try! realm.write {
          realm.delete(meal)
        }
    }
}

