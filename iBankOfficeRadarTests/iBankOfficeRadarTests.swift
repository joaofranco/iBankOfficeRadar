import XCTest
@testable import iBankOfficeRadar

class GooglePlaceServiceTests: XCTestCase {
    
    var mockService: GooglePlaceService!
    var expectation: XCTestExpectation?

    override func setUp() {
        let mockSession = URLSessionMock(dataString: SucessMock.mockString,
                                         httpStatusNumber: SucessMock.mockStatus)
        let mockHttpClient = HttpClient(mockSession)

        mockService = GooglePlaceService(mockHttpClient)
    }

    override func tearDown() {
        
    }

    func testSearch() {
        
        expectation = self.expectation(description: "asynchronous request")
        
        mockService.searchPlaces(latitude: 0.0, longitude: 0.0) { (result) in
            switch result {
            case .success(let response):
                XCTAssert(response.results[0].vicinity == "R. da Consolação, 2279 - Consolação, São Paulo", "First OPlace OK")
            case .error(_):
                XCTFail("invitation error")
            }
            self.expectation?.fulfill()
        }
        self.waitForExpectations(timeout: 10.0, handler: nil)
    }

}

