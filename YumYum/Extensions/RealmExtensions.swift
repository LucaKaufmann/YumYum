//
//  RealmExtensions.swift
//  YumYum
//
//  Created by Luca Kaufmann on 23/07/2019.
//  Copyright © 2019 Luca Kaufmann. All rights reserved.
//

import RealmSwift

protocol CascadeDeleting {
  func hardCascadeDeleteProperties() -> [String]
}

extension Realm {
    func cascadeDelete(_ object: Object) {
        guard let cascading = object as? CascadeDeleting else {
          delete(object)
        return
        }
        for property in cascading.hardCascadeDeleteProperties() {
            if let linkedObject = object.value(forKey: property) as? Object {
                cascadeDelete(linkedObject)
                continue
            }

            if let linkedObjects = object.value(forKey: property) as? ListBase {
            (0..<linkedObjects._rlmArray.count)
                .compactMap {
                linkedObjects._rlmArray.object(at: $0) as? Object
                }
                .forEach(cascadeDelete)
            continue
            }
        }
        
        delete(object)
    }
}
