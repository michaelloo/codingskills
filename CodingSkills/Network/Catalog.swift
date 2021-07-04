//
//  
//

import Foundation

struct Catalog: Equatable {
  struct Item: Equatable {
    let sku: String
    let description: String
    let source: String

    /// **Failable** initialiser which takes a CSV string as input.
    ///
    /// - The string's format is expected to be: `SKU,Description,Source`.
    /// - If the string does not have 3 values the initialiser will *fail* and return `nil`
    ///
    /// - Parameter string: string in a CSV format to parse into an `Item`
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
