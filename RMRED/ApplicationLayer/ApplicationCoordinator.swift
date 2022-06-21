import Combine
import UIKit

class ApplicationCoordinator {
    
    private var window: UIWindow?
    
    private(set) var bag = Set<AnyCancellable>()
    
    init(window: UIWindow?) {
        self.window = window
    }
    
    func updateCharacterDetailsController() {
        guard
            let splitViewController = window?.rootViewController as? UISplitViewController,
            let leftNavController = splitViewController.viewControllers.first
                as? UINavigationController,
            let masterViewController = leftNavController.viewControllers.first
                as? RMCharactersMasterViewController,
            let rightNavController = splitViewController.viewControllers.last as? UINavigationController,
            let detailViewController = rightNavController.viewControllers.first
                as? RMCharacterDetailsViewController
        else { fatalError() }
        
        masterViewController.details = detailViewController
        
        masterViewController
            .charactersViewModel
            .$selectedCharacter
            .sink {
                detailViewController.rmCharacter = $0
            }
            .store(in: &bag)
    }
}

