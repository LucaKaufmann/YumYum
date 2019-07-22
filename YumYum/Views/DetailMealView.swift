//
//  MealView.swift
//  YumYum
//
//  Created by Luca Kaufmann on 27.6.2019.
//  Copyright © 2019 Luca Kaufmann. All rights reserved.
//

import SwiftUI

struct DetailMealView : View {
    
    @State var ingredientsObject: IngredientsObject
    var meal: Meal
    @State var draftName: String = ""
    @State var isTyping: Bool = false
    
    var body: some View {
        VStack {
            Text(meal.name+" ingredients").font(.title)
            List {
                HStack {
                    TextField($draftName, placeholder: Text("Add ingredient..."), onEditingChanged: { editing in
                        self.isTyping = editing
                    },
                              onCommit: {
                                print("committed")
                    })
                    if isTyping {
                        Button(action: { self.addIngredient() }) {
                            Text("Add")
                        }
                    }
                }
                ForEach(meal.ingredients) { ingredient in
                    IngredientRow(name: ingredient.name, amount: ingredient.amount)
                }
            }


        }
    }
    
    private func addIngredient() {
        Ingredient.add(name: self.draftName, amount: 1, meal: meal)
        self.draftName = ""
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
        DetailMealView(mealId: "f1e1696f-788c-482d-acd8-d9c05a7372a4").environmentObject(IngredientsObject())
    }
}
#endif
