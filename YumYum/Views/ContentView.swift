//
//  ContentView.swift
//  YumYum
//
//  Created by Luca Kaufmann on 27.6.2019.
//  Copyright © 2019 Luca Kaufmann. All rights reserved.
//

import SwiftUI

struct ContentView : View {
    
    @EnvironmentObject var userData: UserData
    @State var draftName: String = ""
    @State var isEditing: Bool = false
    
    var body: some View {
        List {
            TextField($draftName, placeholder: Text("Create a New Task..."), onCommit: {
                print("Test")
            })
            ForEach(self.userData.meals) { meal in
                NavigationButton(destination: DetailMealView(selectedMeal: meal)) {
                    MealRow(name: meal.name)
                }
            }
        }
        .navigationBarTitle(Text("Meals"))
        .navigationBarItems(trailing: Button(action: { self.isEditing.toggle() }) {
            if !self.isEditing {
                Text("Edit")
            } else {
                Text("Done").bold()
            }
        })
    }
    
    private func createMeal() {
        let newMeal = Meal(name: self.draftName, ingredients: nil)
        self.userData.meals.insert(newMeal, at: 0)
        self.draftName = ""
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
        ContentView()
    }
}
#endif
