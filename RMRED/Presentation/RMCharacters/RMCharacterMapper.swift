import UIKit

struct RMCharacterMapper {
    
    static func mapToRMCharacterUIModel(_ rmCharacter: RMCharacter,
                                        placeholderImage: UIImage? = UIImage.systemIconPerson) -> RMCharacterUIModel {
        RMCharacterUIModel(photoURL: URL(string: rmCharacter.image),
                           placeholderImage: placeholderImage,
                           name: rmCharacter.name,
                           status: rmCharacter.status,
                           species: rmCharacter.species,
                           gender: rmCharacter.gender,
                           location: rmCharacter.location.name)
    }
}
