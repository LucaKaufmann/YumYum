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

final class MealObject: ObservableObject {
    let willChange = PassthroughSubject<MealObject, Never>()
    
    private var token: NotificationToken!
    var meals: Results<Meal>
    
    init() {
        self.meals = Meal.all()
        lateInit()
    }

    func lateInit() {
        token = meals.observe { changes in
            self.willChange.send(self)
        }
    }

    deinit {
        token.invalidate()
    }
    
}
