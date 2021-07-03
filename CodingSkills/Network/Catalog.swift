//
//  
//

import Foundation

struct Catalog: Equatable {
  struct Item: Equatable {
    let sku: String
    let description: String
    let source: String

    init?(string: String) {
      let substrings = string.split(separator: ",")

      guard substrings.count == 3 else { return nil }

      self.sku = String(substrings[0])
      self.description = String(substrings[1])
      self.source = String(substrings[2])
    }
  }

  let items: [Item]
}
