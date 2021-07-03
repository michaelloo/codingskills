//
//  
//

import Combine

final class DataFetcher: DataStore {
  func fetchCatalog() -> AnyPublisher<Catalog, Never> {
    let dummyData = [
      Catalog.Item(sku: "280-oad-768", description:"Bread - Raisin", source: "A"),
      Catalog.Item(sku: "650-epd-782", description:"Carbonated Water - Lemon Lime", source: "A"),
      Catalog.Item(sku: "999-epd-782", description:"Carbonated Water - Lemon Lime", source: "B"),
      Catalog.Item(sku: "167-eol-949", description:"Cheese - Grana Padano", source: "A"),
      Catalog.Item(sku: "999-eol-949", description:"Cheese - Grana Padano", source: "B"),
      Catalog.Item(sku: "xxx-xxx-xxx", description:"Shiny New Item", source: "C"),
      Catalog.Item(sku: "165-rcy-650", description:"Tea - Decaf 1 Cup", source: "A"),
      Catalog.Item(sku: "647-vyk-317", description:"Walkers Special Old Whiskey", source: "A"),
    ]
    return Just(Catalog(items: dummyData))
      .setFailureType(to: Never.self)
      .eraseToAnyPublisher()
  }
}
