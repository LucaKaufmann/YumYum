//
//  MealView.swift
//  YumYum
//
//  Created by Luca Kaufmann on 27.6.2019.
//  Copyright © 2019 Luca Kaufmann. All rights reserved.
//

import SwiftUI

struct DetailMealView : View {
    
    var selectedMeal: Meal
    
    var body: some View {
        VStack {
            Text(selectedMeal.name+" ingredients").font(.title)
            
            List(selectedMeal.ingredients ?? [Ingredient]()) { ingredient in
                IngredientRow(name: ingredient.name, amount: ingredient.amount)
            }
        }
    }
}

struct IngredientRow: View {
    var name: String
    var amount: Int
    
    var body: some View {
        HStack {
            Text(name)
            Spacer()
            Text("\(amount)")
        }
    }
}

#if DEBUG
struct MealView_Previews : PreviewProvider {
    static var previews: some View {
        DetailMealView(selectedMeal: Meal(name: "Pizza", ingredients: [Ingredient(name: "Cheese", amount: 1), Ingredient(name: "Tomato sauce", amount: 1)]))
    }
}
#endif
