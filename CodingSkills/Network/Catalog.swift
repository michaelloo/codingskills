//
//  
//

import Foundation

struct Catalog: Equatable {
  struct Item: Equatable {
    let sku: String
    let description: String
    let source: String
  }

  let items: [Item]
}
