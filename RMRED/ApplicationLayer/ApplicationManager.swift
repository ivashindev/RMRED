import UIKit

final class ApplicationManager {
    
    static let shared = ApplicationManager()
    
    let charactersRepository: CharactersRepository
    private(set) var coordinator: ApplicationCoordinator!
    
    private init() {
        let httpsClient = RestRequestService()
        self.charactersRepository = CharactersDataService(httpsClient: httpsClient)
    }
    
    func runCoordinator(window: UIWindow?) {
        coordinator = ApplicationCoordinator(window: window)
        coordinator.updateCharacterDetailsController()
    }
}
