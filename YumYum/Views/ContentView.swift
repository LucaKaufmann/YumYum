//
//  ContentView.swift
//  YumYum
//
//  Created by Luca Kaufmann on 27.6.2019.
//  Copyright © 2019 Luca Kaufmann. All rights reserved.
//

import SwiftUI

struct ContentView : View {
    
    @EnvironmentObject var userData: MealObject
    @State var draftName: String = ""
    @State var isEditing: Bool = false
    @State var isTyping: Bool = false
    
    var body: some View {
        List {
            HStack {
                TextField($draftName, placeholder: Text("Add meal..."), onEditingChanged: { editing in
                    self.isTyping = editing
                },
                onCommit: {
                    self.createMeal()
                    })
                if isTyping {
                    Button(action: { self.createMeal() }) {
                        Text("Add")
                    }
                }
            }
            ForEach(self.userData.meals) { meal in
                if Meal.objectExists(id: meal.id) {
                    NavigationLink(destination: DetailMealView(ingredientsObject: IngredientsObject(meal: meal))) {
                        MealRow(name: meal.name)
                    }
                }
            }.onDelete(perform: delete)
        }
        .navigationBarTitle(Text("Meals"))
    }
    
    private func createMeal() {
        guard self.draftName != "" else {
            return
        }
        Meal.add(name: self.draftName)
        self.draftName = ""
    }
    
    func delete(at offsets: IndexSet) {
        guard let index = offsets.first else {
            return
        }
        let mealToDelete = userData.meals[index]
        Meal.delete(meal: mealToDelete)
    }
}

struct MealRow: View {
    var name: String
    
    var body: some View {
        Text(name)
    }
}

#if DEBUG
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        NavigationView {
            ContentView().environmentObject(MealObject())
        }
    }
}
#endif
