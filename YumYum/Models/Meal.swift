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
    
    override class func primaryKey() -> String? {
           return "id"
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

