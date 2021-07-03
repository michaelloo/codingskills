//
//  
//

import SwiftUI
import Combine

protocol DataStore {
  func fetchCatalog() -> AnyPublisher<Catalog, Never>
}

final class ContentViewModel: ObservableObject {
  struct ViewItem: Equatable, Identifiable {
    let text: String

    let id: String = UUID().uuidString
  }

  @Published var viewItems: [ViewItem] = []
  var screenTitle: String = "Catalog"
  
  private let dataStore: DataStore
  private var cancellables: Set<AnyCancellable> = .init()

  init(dataStore: DataStore) {
    self.dataStore = dataStore
  }

  func loadViewItems() {
    dataStore.fetchCatalog()
      .map { $0.items.map(ViewItem.init(catalogItem:)) }
      .assign(to: \.viewItems, on: self)
      .store(in: &cancellables)
  }
}

private extension ContentViewModel.ViewItem {
  init(catalogItem: Catalog.Item) {
    self.text = [catalogItem.source, catalogItem.sku, catalogItem.description].joined(separator: " | ")
  }
}
