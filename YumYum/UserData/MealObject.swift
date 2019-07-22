//
//  UserData.swift
//  YumYum
//
//  Created by Luca Kaufmann on 27.6.2019.
//  Copyright © 2019 Luca Kaufmann. All rights reserved.
//

import Combine
import SwiftUI
import RealmSwift

private let defaultMeals: [Meal] = [
    Meal(id: "f1e1696f-788c-482d-acd8-d9c05a7372a4", name: "Pizza"),
    Meal(id: "17fb10c6-009c-4286-9a8e-bdeb04000c55", name: "Spaghetti"),
]

final class MealObject: BindableObject {
    let willChange = PassthroughSubject<MealObject, Never>()
    
    private var token: NotificationToken!
    var meals: Results<Meal>
    
    init() {
        self.meals = Meal.all()
        lateInit()
    }

    func lateInit() {
        token = meals.observe { _ in
            self.willChange.send(self)
        }
    }

    deinit {
        token.invalidate()
    }
    
    func mealForId(mealId: String) -> Meal {
        if let meal = meals.first(where: {$0.id == mealId}) {
            return meal
        } else {
            return Meal("Placeholder")
        }
    }
    
    func update(meal: Meal) {
//        if let row = self.meals.firstIndex(where: {$0.id == meal.id}) {
//            self.meals[row] = meal
//        }
    }
}
