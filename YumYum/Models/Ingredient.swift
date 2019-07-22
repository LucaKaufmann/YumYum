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
}
