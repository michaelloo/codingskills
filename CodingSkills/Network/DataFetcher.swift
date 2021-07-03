//
//  
//

import Combine
import Foundation

final class DataFetcher: DataStore {
  private let path: String

  init(path: String = Bundle.main.path(forResource: "script_output", ofType: "csv")!) {
    self.path = path
  }

  func fetchCatalog() -> AnyPublisher<Catalog, Never> {
    guard let content = try? String(contentsOfFile: path).split(separator: "\n").dropFirst() else {
      return Empty().eraseToAnyPublisher()
    }

    return Just(Catalog(items: content.map(String.init).compactMap(Catalog.Item.init)))
      .setFailureType(to: Never.self)
      .eraseToAnyPublisher()
  }
}
