//
//  Ingredient.swift
//  YumYum
//
//  Created by Luca Kaufmann on 27.6.2019.
//  Copyright © 2019 Luca Kaufmann. All rights reserved.
//

import SwiftUI

struct Ingredient: Equatable, Hashable, Codable, Identifiable {
    let id: UUID
    var name: String
    var amount: Int
    
    init(name: String, amount: Int) {
        self.id = UUID()
        self.name = name
        self.amount = amount
    }
}
