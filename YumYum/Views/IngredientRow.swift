//
//  IngredientsRow.swift
//  YumYum
//
//  Created by Luca Kaufmann on 27.3.2020.
//  Copyright © 2020 Luca Kaufmann. All rights reserved.
//

import SwiftUI

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

struct IngredientRow_Previews: PreviewProvider {
    static var previews: some View {
        IngredientRow(ingredient: Ingredient(name: "Spaghetti", amount: 1, meal: Meal("Spaghetti")))
    }
}
