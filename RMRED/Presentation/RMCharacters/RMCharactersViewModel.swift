import SwiftUI
import Combine

class RMCharactersViewModel {
    
    @Published private(set) var characters: [RMCharacterUIModel] = []
    @Published private(set) var selectedCharacter: RMCharacterUIModel? = nil
    
    private let applicationManager: ApplicationManager
    private(set) var charactersCache: [RMCharacterUIModel] = []
    
    private(set) var bag = Set<AnyCancellable>()
    
    init(applicationManager: ApplicationManager = ApplicationManager.shared) {
        self.applicationManager = applicationManager
        getCharacters()
    }
    
    func prepareCharacterFor(row: Int) -> RMCharacterRowUIModel {
        return RMCharacterRowUIModel(photoURL: characters[row].photoURL,
                                     name: characters[row].name,
                                     placeholderImage: characters[row].placeholderImage)
    }
    
    func userDidSelect(row: Int) {
        selectedCharacter = characters[row]
    }
    
    func userDidSearchForCharacter(with name: String) {
        guard !name.isEmpty else {
            characters = charactersCache
            return
        }
        characters = charactersCache.filter { $0.name.contains(name) }
    }
    
    func userDidFinishSearch() {
        characters = charactersCache
    }

    private func getCharacters() {
        applicationManager
            .charactersRepository
            .getCharacters(page: 1, decoder: defaultDecoder)
            .removeDuplicates()
            .sink { _ in
                print("\(#file): \(#line) - I'm done :-)")
            } receiveValue: { [weak self] in
                guard let self = self else { return }
                self.characters = $0.map { RMCharacterMapper.mapToRMCharacterUIModel($0) }
                self.selectedCharacter = self.characters.first
                self.charactersCache = self.characters
            }.store(in: &bag)
    }
}
