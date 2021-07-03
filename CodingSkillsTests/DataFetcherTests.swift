//
//  
//

import Combine
import XCTest

@testable import CodingSkills

final class DataFetcherTests: XCTestCase {
  private var dataFetcher: DataFetcher!
  private var cancellables: Set<AnyCancellable> = .init()

  override func tearDown() {
    cancellables.removeAll()
    dataFetcher = nil

    super.tearDown()
  }

  func test_fetchCatalog_success() {
    dataFetcher = DataFetcher(path: Bundle(for: type(of: self)).path(forResource: "test_catalog", ofType: "csv")!)

    let expectedCatalog = Catalog(items: [
      Catalog.Item(string: "aaa-bbb-ccc,Foo,X")!,
      Catalog.Item(string: "bbb-aaa-ccc,Bar,Y")!,
      Catalog.Item(string: "ddd-bbb-ccc,FooBar,X")!,
    ])
    var catalog: Catalog?

    let expectation = self.expectation(description: "test_fetchCatalog_success")

    dataFetcher.fetchCatalog().sink(receiveCompletion: { _ in }, receiveValue: {
      catalog = $0
      expectation.fulfill()
    }).store(in: &cancellables)

    waitForExpectations(timeout: 0.1)

    XCTAssertEqual(catalog, expectedCatalog)
  }

  func test_fetchCatalog_failure() {
    dataFetcher = DataFetcher(path: "")

    var error: DataStoreError?

    let expectation = self.expectation(description: "test_fetchCatalog_failure")

    dataFetcher.fetchCatalog().sink(
      receiveCompletion: { completion in
        switch completion {
        case let .failure(_error):
          error = _error
        case .finished: break
        }
        expectation.fulfill()
      },
      receiveValue: { _ in }
    ).store(in: &cancellables)

    waitForExpectations(timeout: 0.1)

    XCTAssertEqual(error, DataStoreError.contentMissing)
  }
}
