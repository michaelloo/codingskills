//
//  
//

import Combine
import Foundation

/// Class responsible for fetching the catalog data to be displayed to users
final class DataFetcher: DataStore {
  private let path: String

  /// Initialiser which takes in the `path` to the CSV file.
  /// - Parameter path: path to the csv file which is in the `Bundle`
  init(path: String = Bundle.main.path(forResource: "script_output", ofType: "csv")!) {
    self.path = path
  }

  func fetchCatalog() -> AnyPublisher<Catalog, DataStoreError> {
    guard let content = try? String(contentsOfFile: path).split(separator: "\n").dropFirst() else {
      return Fail(error: DataStoreError.contentMissing).eraseToAnyPublisher()
    }

    return Just(Catalog(items: content.map(String.init).compactMap(Catalog.Item.init)))
      .setFailureType(to: DataStoreError.self)
      .eraseToAnyPublisher()
  }
}
