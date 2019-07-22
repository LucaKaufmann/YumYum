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

final class UserData: BindableObject {
    let didChange = PassthroughSubject<UserData, Never>()
    
    private var notificationTokens: [NotificationToken] = []
    var meals: RealmSwift.List<Meal>
    
    init() {
        // Observe changes in the underlying model
        self.notificationTokens.append(meals.observe { _ in
            self.didChange.send(self)
        })
        
        self.notificationTokens.append(meals.all.observe { _ in
            self.didChange.send(self)
        })
    }
    
    func mealForId(mealId: String) -> Meal {
        if let meal = meals.first(where: {$0.id == mealId}) {
            return meal
        } else {
            return Meal("Placeholder")
        }
    }
    
    func update(meal: Meal) {
        if let row = self.meals.firstIndex(where: {$0.id == meal.id}) {
            self.meals[row] = meal
        }
    }
}
