import Foundation

class SucessMock {
    static let mockStatus = 200
    static var mockString: String {
        var string = ""
        if let filepath = Bundle.main.path(forResource: "googleplace-nearbysearch", ofType: "json") {
            do {
                string = try String(contentsOfFile: filepath)
            } catch { }
        }
        return string
    }
}

class NextDataTaskMock: URLSessionDataTask {
    private (set) var resumeWasCalled = false
    
    override func resume() {
        resumeWasCalled = true
    }
}

public class URLSessionMock: URLSessionProtocol {
    var nextDataTask = NextDataTaskMock()
    var dataString = ""
    var httpStatusNumber = 200
    
    init(dataString: String, httpStatusNumber: Int) {
        self.dataString = dataString
        self.httpStatusNumber = httpStatusNumber
    }
    
    public func dataTask(with request: URLRequest,
                  completionHandler: @escaping (Data?, URLResponse?, Error?) -> Swift.Void) -> URLSessionDataTask {
        let str = self.dataString
        let data = str.data(using: String.Encoding.utf8)
        let response = HTTPURLResponse(url: NSURL() as URL,
                                       statusCode: self.httpStatusNumber,
                                       httpVersion: nil,
                                       headerFields: nil)
        completionHandler(data, response, nil)
        return nextDataTask
    }
}
