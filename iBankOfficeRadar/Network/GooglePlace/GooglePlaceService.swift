import Foundation

private func UITesting() -> Bool {
    return ProcessInfo.processInfo.arguments.contains("UI-TESTING")
}

public class GooglePlaceService {
    
    private let httpClient: HttpClient

    init(_ httpClient: HttpClient = HttpClient()) {
        if UITesting() {
             let mockSession = URLSessionMock(dataString: SucessMock.mockString,
                                                    httpStatusNumber: SucessMock.mockStatus)
            let mockHttpClient = HttpClient(mockSession)
            self.httpClient = mockHttpClient
        } else {
            self.httpClient = httpClient
        }
    }

    public func searchPlaces(latitude: Double, longitude: Double,
                completion: @escaping (HTTPResult<GooglePlaceNearByResponse, Error>) -> Void) {

        let definition = GooglePlaceDefinition.searchPlaces(latitude: latitude, longitude: longitude)
        
        httpClient.request(endpoint: definition.path,
                           httpMethod: definition.method,
                           completion: completion)
    }

}
