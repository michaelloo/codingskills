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
    ]

    viewModel.loadViewItems()

    XCTAssertEqual(viewModel.viewItems.map(\.text), expectedTexts)
  }
}

private final class DataStoreStub: DataStore {
  func fetchCatalog() -> AnyPublisher<Catalog, DataStoreError> {
    let items = [
      Catalog.Item(string: "280-oad-768,Bread - Raisin,A")!,
      Catalog.Item(string: "650-epd-782,Carbonated Water - Lemon Lime,A")!,
      Catalog.Item(string: "999-epd-782,Carbonated Water - Lemon Lime,B")!,
    ]
    return Just(Catalog(items: items))
      .setFailureType(to: DataStoreError.self)
      .eraseToAnyPublisher()
  }
}
