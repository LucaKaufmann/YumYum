//
//  IngredientObject.swift
//  YumYum
//
//  Created by Luca Kaufmann on 22/07/2019.
//  Copyright © 2019 Luca Kaufmann. All rights reserved.
//

import Combine
import SwiftUI
import RealmSwift

final class IngredientsObject: BindableObject {
    let willChange = PassthroughSubject<IngredientsObject, Never>()
    
    private var token: NotificationToken!
    var ingredients: LinkingObjects<Ingredient>
    var meal: Meal
    
    init(meal: Meal) {
        self.meal = meal
        self.ingredients = meal.ingredients
        lateInit()
    }

    func lateInit() {
        token = ingredients.observe { changes in
            print("Changes: \(changes)")
            self.willChange.send(self)
        }
    }

    deinit {
        token.invalidate()
    }
}
