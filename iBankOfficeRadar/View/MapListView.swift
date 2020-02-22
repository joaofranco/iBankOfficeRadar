import SwiftUI
import CoreLocation

struct ContentView: View {
    @ObservedObject var viewModel = MapListViewModel()
    
    var body: some View {
        ZStack {
            NavigationView {
                MapView(
                    actualLocation: $viewModel.actualLocation,
                    places: $viewModel.places,
                    showingDetail: $viewModel.showingDetail,
                    placeTapped: $viewModel.placeTapped)
                    .edgesIgnoringSafeArea(.vertical)
                    .navigationBarTitle(Text("iBank Office Radar"), displayMode: .inline)
                    .navigationBarItems(trailing:
                                VStack {
                                    Text(viewModel.statusMessage)
                    })
            }.sheet(isPresented: $viewModel.showingDetail) {
                BankOfficeDetailView(place: self.viewModel.placeTapped)
               }
        }
    }
}

#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif

