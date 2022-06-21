import Combine
import Foundation

protocol HTTPSClient {
    func request(request: URLRequest) -> AnyPublisher<Data, Error>
}

class RestRequestService: HTTPSClient {
    
    func request(request: URLRequest) -> AnyPublisher<Data, Error> {
        return URLSession
            .shared
            .dataTaskPublisher(for: request)
            .tryMap {
                if let httpResponse = $1 as? HTTPURLResponse, httpResponse.statusCode != 200 {
                    throw URLError(URLError.Code(rawValue: httpResponse.statusCode))
                }
                
                guard $0.count > 0 else { throw URLError(.zeroByteResource) }
                return $0
                
            }.eraseToAnyPublisher()
    }
}
