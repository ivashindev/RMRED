import Foundation

struct RMCharacter: Decodable, Equatable {
    let name: String
    let image: String
    let status: String
    let species: String
    let gender: String
    let location: Location
    let episode: [String]
}

struct Location: Decodable, Equatable {
    let name: String
    let url: String
}

struct RMCharacters: Decodable {
    let results: [RMCharacter]
}
