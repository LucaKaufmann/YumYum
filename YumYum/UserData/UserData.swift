//
//  UserData.swift
//  YumYum
//
//  Created by Luca Kaufmann on 27.6.2019.
//  Copyright © 2019 Luca Kaufmann. All rights reserved.
//

import Combine
import SwiftUI

private let defaultMeals: [Meal] = [
    Meal(id: UUID(uuidString: "f1e1696f-788c-482d-acd8-d9c05a7372a4")!, name: "Pizza", ingredients: [Ingredient(name: "Cheese", amount: 1), Ingredient(name: "Tomato Sauce", amount: 1)]),
    Meal(id: UUID(uuidString: "17fb10c6-009c-4286-9a8e-bdeb04000c55")!, name: "Spaghetti", ingredients: [Ingredient(name: "Spaghetti", amount: 1), Ingredient(name: "Tomato Sauce", amount: 1)]),
]

final class UserData: BindableObject {
    let didChange = PassthroughSubject<UserData, Never>()
    
    @UserDefaultValue(key: "Meals", defaultValue: defaultMeals)
    var meals: [Meal] {
        didSet {
            didChange.send(self)
        }
    }
    
    func mealForId(mealId: UUID) -> Meal {
        if let meal = meals.first(where: {$0.id == mealId}) {
            return meal
        } else {
            return Meal(name: "Placeholder", ingredients: nil)
        }
    }
    
    func update(meal: Meal) {
        if let row = self.meals.firstIndex(where: {$0.id == meal.id}) {
            self.meals[row] = meal
        }
    }
}
