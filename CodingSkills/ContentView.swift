//
//  
//

import SwiftUI

struct ContentView: View {
  @ObservedObject private var viewModel: ContentViewModel = ContentViewModel(dataStore: DataFetcher())

  var body: some View {
    List(viewModel.items) { item in
      HStack {
        Text(item.description)
        Text(item.sku)
        Text(item.source)
      }
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
