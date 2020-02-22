import Foundation

public class HttpClient {
    
    fileprivate var session: URLSessionProtocol
    
    init(_ session: URLSessionProtocol = URLSession.shared) {
        self.session = session
    }
    
    func request<T: Decodable>(endpoint: String,
                               httpMethod: HttpMethod,
                               _ parameters: [String: String] = [String: String](),
                               completion: @escaping (HTTPResult<T, Error>) -> Void) {
        print(endpoint)
        var components = URLComponents(string: endpoint)!
        var request = URLRequest(url: components.url!)
        parameters.forEach { components.queryItems?.append(URLQueryItem(name: $0, value: $1)) }
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = httpMethod.rawValue
        self.session.dataTask(with: request, completionHandler: { (data, response , error) in
            if data != nil && error == nil {
                do {
                    print(String(data: data!, encoding: .utf8) ?? "")
                    let objectDecoded = try JSONDecoder().decode(T.self, from: data!)
                    completion(.success(objectDecoded))
                } catch {
                    completion(.error(error))
                }
                return
            }
            completion(.error(error!))
        }).resume()
    }
}
