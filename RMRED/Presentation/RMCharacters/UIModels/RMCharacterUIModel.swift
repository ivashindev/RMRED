import UIKit

struct RMCharacterUIModel {
    let photoURL: URL?
    let placeholderImage: UIImage?
    let name: String
    let status: String
    let species: String
    let gender: String
    let location: String
}

extension RMCharacterUIModel: Equatable {
    static func == (lhs: RMCharacterUIModel, rhs: RMCharacterUIModel) -> Bool {
        return lhs.photoURL == rhs.photoURL &&
        (lhs.placeholderImage ?? UIImage()).pngData()
        == (rhs.placeholderImage ?? UIImage()).pngData() &&
        lhs.name == rhs.name &&
        lhs.status == rhs.status &&
        lhs.species == rhs.species &&
        lhs.gender == rhs.gender &&
        lhs.location == rhs.location
    }
}
