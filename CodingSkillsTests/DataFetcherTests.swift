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

    dataFetcher = DataFetcher(path: Bundle(for: type(of: self)).path(forResource: "test_catalog", ofType: "csv")!)
  }

  override func tearDown() {
    cancellables.removeAll()

    super.tearDown()
  }

  func test_fetchCatalog() {
    let expectedCatalog = Catalog(items: [
      Catalog.Item(string: "aaa-bbb-ccc,Foo,X")!,
      Catalog.Item(string: "bbb-aaa-ccc,Bar,Y")!,
      Catalog.Item(string: "ddd-bbb-ccc,FooBar,X")!,
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
