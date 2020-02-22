import Foundation
import MapKit
import Combine

class MapListViewModel: ObservableObject {
    @Published var statusMessage = ""
    @Published var showingDetail = false
    var placeTapped: Place = testPlace
    var actualLocation : CLLocationCoordinate2D {
        didSet {
            self.searchBankOffices()
        }
    }
    var places = [Place]()
    var service: GooglePlaceService
    var initiliazing = true
    
    init(_ service: GooglePlaceService = GooglePlaceService(),
         _ actualLocation: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: -23.558571, longitude: -46.677745)) {
        self.service = service
        self.actualLocation = actualLocation
    }
    
    private func searchBankOffices() {
        if initiliazing {
            initiliazing = false
            return
        }
        statusMessage = "Carregando"
        service.searchPlaces(latitude: actualLocation.latitude,
                             longitude: actualLocation.longitude) { (result) in
                switch result {
                case .success(let response):
                    if response.status == "OK" {
                        self.statusMessage = ""
                        self.places = response.results
                    } else {
                        self.statusMessage = "ERRO"
                    }
                case .error(_):
                    self.statusMessage = "Erro"
                }
        }
    }
}
