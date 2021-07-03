//
//  
//

import Combine
import XCTest

@testable import CodingSkills

final class DataFetcherTests: XCTestCase {
  private var dataFetcher: DataFetcher!
  private var cancellables: Set<AnyCancellable> = .init()

  override func setUp() {
    super.setUp()

    dataFetcher = DataFetcher()
  }

  override func tearDown() {
    cancellables.removeAll()

    super.tearDown()
  }

  func test_fetchCatalog() {
    let expectedCatalog = Catalog(items: [
      Catalog.Item(sku: "280-oad-768", description:"Bread - Raisin", source: "A"),
      Catalog.Item(sku: "650-epd-782", description:"Carbonated Water - Lemon Lime", source: "A"),
      Catalog.Item(sku: "999-epd-782", description:"Carbonated Water - Lemon Lime", source: "B"),
      Catalog.Item(sku: "167-eol-949", description:"Cheese - Grana Padano", source: "A"),
      Catalog.Item(sku: "999-eol-949", description:"Cheese - Grana Padano", source: "B"),
      Catalog.Item(sku: "xxx-xxx-xxx", description:"Shiny New Item", source: "C"),
      Catalog.Item(sku: "165-rcy-650", description:"Tea - Decaf 1 Cup", source: "A"),
      Catalog.Item(sku: "647-vyk-317", description:"Walkers Special Old Whiskey", source: "A"),
    ])
    var catalog: Catalog?

    let expectation = self.expectation(description: "test_fetchCatalog_succeeds")

    dataFetcher.fetchCatalog().sink {
      catalog = $0
      expectation.fulfill()
    }.store(in: &cancellables)

    waitForExpectations(timeout: 0.1)

    XCTAssertEqual(catalog, expectedCatalog)
  }
}
