//
//  Ingredient.swift
//  YumYum
//
//  Created by Luca Kaufmann on 27.6.2019.
//  Copyright © 2019 Luca Kaufmann. All rights reserved.
//

import SwiftUI
import RealmSwift

@objcMembers class Ingredient: Object {
    dynamic var id = UUID().uuidString
    dynamic var name = ""
    dynamic var amount = 0
    
    convenience init(name: String, amount: Int) {
        self.init()
        self.name = name
        self.amount = amount
    }
}

//struct Ingredient: Equatable, Hashable, Codable, Identifiable {
//    let id: UUID
//    var name: String
//    var amount: Int
//
//    init(name: String, amount: Int) {
//        self.id = UUID()
//        self.name = name
//        self.amount = amount
//    }
//
//    init(id: UUID, name: String, amount: Int) {
//        self.id = id
//        self.name = name
//        self.amount = amount
//    }
//}
