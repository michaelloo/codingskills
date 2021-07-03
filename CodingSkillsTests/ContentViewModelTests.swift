//
//  
//

import Combine
import XCTest

@testable import CodingSkills

final class ContentViewModelTests: XCTestCase {
  var viewModel: ContentViewModel!

  override func setUp() {
    super.setUp()

    viewModel = ContentViewModel(dataStore: DataStoreStub())
  }

  func test_intitialisation() {
    XCTAssertEqual(viewModel.screenTitle, "Catalog")
    XCTAssertTrue(viewModel.viewItems.isEmpty)
  }

  func test_loadViewItems() {
    let expectedTexts = [
      "A | 280-oad-768 | Bread - Raisin",
      "A | 650-epd-782 | Carbonated Water - Lemon Lime",
      "B | 999-epd-782 | Carbonated Water - Lemon Lime",
      "A | 167-eol-949 | Cheese - Grana Padano",
      "B | 999-eol-949 | Cheese - Grana Padano",
      "C | xxx-xxx-xxx | Shiny New Item",
      "A | 165-rcy-650 | Tea - Decaf 1 Cup",
      "A | 647-vyk-317 | Walkers Special Old Whiskey",
    ]

    viewModel.loadViewItems()

    XCTAssertEqual(viewModel.viewItems.map(\.text), expectedTexts)
  }
}

private final class DataStoreStub: DataStore {
  func fetchCatalog() -> AnyPublisher<Catalog, Never> {
    let items = [
      Catalog.Item(sku: "280-oad-768", description:"Bread - Raisin", source: "A"),
      Catalog.Item(sku: "650-epd-782", description:"Carbonated Water - Lemon Lime", source: "A"),
      Catalog.Item(sku: "999-epd-782", description:"Carbonated Water - Lemon Lime", source: "B"),
      Catalog.Item(sku: "167-eol-949", description:"Cheese - Grana Padano", source: "A"),
      Catalog.Item(sku: "999-eol-949", description:"Cheese - Grana Padano", source: "B"),
      Catalog.Item(sku: "xxx-xxx-xxx", description:"Shiny New Item", source: "C"),
      Catalog.Item(sku: "165-rcy-650", description:"Tea - Decaf 1 Cup", source: "A"),
      Catalog.Item(sku: "647-vyk-317", description:"Walkers Special Old Whiskey", source: "A"),
    ]
    return Just(Catalog(items: items))
      .setFailureType(to: Never.self)
      .eraseToAnyPublisher()
  }
}
