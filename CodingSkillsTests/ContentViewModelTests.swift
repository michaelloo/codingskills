//
//  
//

import XCTest

@testable import CodingSkills

final class ContentViewModelTests: XCTestCase {
  var viewModel: ContentViewModel!

  override func setUp() {
    super.setUp()

    viewModel = ContentViewModel(dataStore: DataStoreStub())
  }

  func test_intitialisation() {
    let expectedItems = [
      ContentViewModel.Item(sku: "280-oad-768", description:"Bread - Raisin", source: "A"),
      ContentViewModel.Item(sku: "650-epd-782", description:"Carbonated Water - Lemon Lime", source: "A"),
      ContentViewModel.Item(sku: "999-epd-782", description:"Carbonated Water - Lemon Lime", source: "B"),
      ContentViewModel.Item(sku: "167-eol-949", description:"Cheese - Grana Padano", source: "A"),
      ContentViewModel.Item(sku: "999-eol-949", description:"Cheese - Grana Padano", source: "B"),
      ContentViewModel.Item(sku: "xxx-xxx-xxx", description:"Shiny New Item", source: "C"),
      ContentViewModel.Item(sku: "165-rcy-650", description:"Tea - Decaf 1 Cup", source: "A"),
      ContentViewModel.Item(sku: "647-vyk-317", description:"Walkers Special Old Whiskey", source: "A"),
    ]

    XCTAssertEqual(viewModel.items, expectedItems)
  }
}

private final class DataStoreStub: DataStore {}
