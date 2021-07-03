//
//  
//

import SwiftUI
import Combine

enum DataStoreError: Error {
  case contentMissing
}

protocol DataStore {
  func fetchCatalog() -> AnyPublisher<Catalog, DataStoreError>
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
      .sink(receiveCompletion: { _ in }, receiveValue: { [weak self] in self?.viewItems = $0 })
      .store(in: &cancellables)
  }
}

private extension ContentViewModel.ViewItem {
  init(catalogItem: Catalog.Item) {
    self.text = [catalogItem.source, catalogItem.sku, catalogItem.description].joined(separator: " | ")
  }
}
