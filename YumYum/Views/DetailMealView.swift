//
//  MealView.swift
//  YumYum
//
//  Created by Luca Kaufmann on 27.6.2019.
//  Copyright © 2019 Luca Kaufmann. All rights reserved.
//

import SwiftUI

struct DetailMealView : View {
    
    @ObjectBinding var ingredientsObject: IngredientsObject
    @State var draftName: String = ""
    @State var isTyping: Bool = false
    var meal: Meal {
        ingredientsObject.meal
    }
    
    var body: some View {
        VStack {
            Text(meal.name+" ingredients").font(.title)
            List {
                HStack {
                    TextField($draftName, placeholder: Text("Add ingredient..."), onEditingChanged: { editing in
                        self.isTyping = editing
                    },
                              onCommit: {
                                self.addIngredient()
                    })
                    if isTyping {
                        Button(action: { self.addIngredient() }) {
                            Text("Add")
                        }
                    }
                }
                ForEach(ingredientsObject.ingredients) { ingredient in
                    if Ingredient.objectExists(id: ingredient.id) {
                        IngredientRow(ingredient: ingredient)
                    }
                }.onDelete(perform: delete)
            }


        }
    }
    
    private func addIngredient() {
        guard self.draftName != "" else {
            return
        }
        Ingredient.add(name: self.draftName, amount: 1, meal: meal)
        self.draftName = ""
    }
    
    func delete(at offsets: IndexSet) {
        guard let index = offsets.first else {
            return
        }
        let ingredientToDelete = ingredientsObject.meal.ingredients[index]
        Ingredient.delete(ingredient: ingredientToDelete)
    }
}

struct IngredientRow: View {
    var ingredient: Ingredient
    
    var body: some View {
        HStack {
            Text(ingredient.name)
            Spacer()
            Text("\(ingredient.amount)")
        }
    }
}

#if DEBUG
struct MealView_Previews : PreviewProvider {
    static var previews: some View {
        DetailMealView(ingredientsObject: IngredientsObject(meal: Meal("Test")))
    }
}
#endif
