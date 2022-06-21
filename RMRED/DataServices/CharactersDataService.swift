import Foundation
import Combine

enum Endpoint {
    static let base = "https://rickandmortyapi.com/api/"
    static let character = "character/"
    static let page = "page"
}

enum HttpMethod {
    static let get = "GET"
}

protocol CharactersRepository {
    func getCharacters(page: Int, decoder: JSONDecoder) -> AnyPublisher<[RMCharacter], Error>
}

class CharactersDataService: CharactersRepository {
    
    private let httpsClient: HTTPSClient
    
    init(httpsClient: HTTPSClient) {
        self.httpsClient = httpsClient
    }
    
    func getCharacters(page: Int, decoder: JSONDecoder) -> AnyPublisher<[RMCharacter], Error> {
        var urlComponents = URLComponents(string: Endpoint.base + Endpoint.character)!
        urlComponents.queryItems = [URLQueryItem(name: Endpoint.page, value: String(page))]
        
        var request = URLRequest(url: urlComponents.url!)
        request.httpMethod = HttpMethod.get
        
        return httpsClient
            .request(request: request)
            .tryMap {
                let characters = try decoder.decode(RMCharacters.self, from: $0)
                return characters.results
            }
            .eraseToAnyPublisher()
    }
}
