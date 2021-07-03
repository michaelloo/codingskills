//
//  
//

import Combine

protocol DataStore {}

final class ContentViewModel: ObservableObject {
  struct Item: Equatable, Identifiable {
    let sku: String
    let description: String
    let source: String

    var id: String { sku }
  }

  @Published var items: [Item] = [
    Item(sku: "280-oad-768", description:"Bread - Raisin", source: "A"),
    Item(sku: "650-epd-782", description:"Carbonated Water - Lemon Lime", source: "A"),
    Item(sku: "999-epd-782", description:"Carbonated Water - Lemon Lime", source: "B"),
    Item(sku: "167-eol-949", description:"Cheese - Grana Padano", source: "A"),
    Item(sku: "999-eol-949", description:"Cheese - Grana Padano", source: "B"),
    Item(sku: "xxx-xxx-xxx", description:"Shiny New Item", source: "C"),
    Item(sku: "165-rcy-650", description:"Tea - Decaf 1 Cup", source: "A"),
    Item(sku: "647-vyk-317", description:"Walkers Special Old Whiskey", source: "A"),
  ]
  
  private let dataStore: DataStore

  init(dataStore: DataStore) {
    self.dataStore = dataStore
  }
}

