//
//  String+urlEncode.swift
//  YumYum
//
//  Created by Luca Kaufmann on 24/07/2019.
//  Copyright © 2019 Luca Kaufmann. All rights reserved.
//

import Foundation

extension String {
  func stringByAddingPercentEncodingForRFC3986() -> String? {
    return self.addingPercentEncoding(withAllowedCharacters: CharacterSet.alphanumerics)
  }
}
