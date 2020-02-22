import XCTest

class iBankOfficeRadarUITests: XCTestCase {

    override func setUp() {
        continueAfterFailure = false
    }

    override func tearDown() {
    }

    func testCheckBankOfficerDetail() {
                
        let app = XCUIApplication()
        app.launchArguments += ["UI-TESTING"]
        app.launch()
        
        //sleep(3)
        let annotation = app.maps.element.otherElements["Agência Itaú"]
        annotation.tap()
        
        app.images["bank"].swipeDown()
    }
}
