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
    
    var body: some View {
        List(self.userData.meals) { meal in
                NavigationButton(destination: DetailMealView(selectedMeal: meal)) {
                    MealRow(name: meal.name)
                }
            }
            .navigationBarTitle(Text("Meals"))
        
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
