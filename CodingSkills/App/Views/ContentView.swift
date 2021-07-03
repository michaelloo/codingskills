//
//  
//

import SwiftUI

struct ContentView: View {
  @ObservedObject private var viewModel: ContentViewModel = ContentViewModel(dataStore: DataFetcher())

  var body: some View {
    NavigationView {
      List(viewModel.viewItems) { item in
        Text(item.text)
      }
      .navigationTitle(viewModel.screenTitle)
      .onAppear(perform: viewModel.loadViewItems)
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
