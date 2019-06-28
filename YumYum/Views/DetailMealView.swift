//
//  MealView.swift
//  YumYum
//
//  Created by Luca Kaufmann on 27.6.2019.
//  Copyright © 2019 Luca Kaufmann. All rights reserved.
//

import SwiftUI

struct DetailMealView : View {
    
    @EnvironmentObject var userData: UserData
    var mealId: UUID
    var selectedMeal: Meal {
        userData.mealForId(mealId: mealId)
    }
    @State var draftName: String = ""
    @State var isTyping: Bool = false
    
    var body: some View {
        VStack {
            Text(selectedMeal.name+" ingredients").font(.title)
            List {
                HStack {
                    TextField($draftName, placeholder: Text("Add ingredient..."), onEditingChanged: { editing in
                        self.isTyping = editing
                    },
                              onCommit: {
                                print("add ingredient")
                    })
                    if isTyping {
                        Button(action: { print("add ingredient") }) {
                            Text("Add")
                        }
                    }
                }
                ForEach(selectedMeal.ingredients ?? [Ingredient]()) { ingredient in
                    IngredientRow(name: ingredient.name, amount: ingredient.amount)
                }
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
        DetailMealView(mealId: 1).environmentObject(UserData())
    }
}
#endif
