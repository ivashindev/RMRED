import UIKit
import Combine

class RMCharactersMasterViewController: UITableViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    let charactersViewModel: RMCharactersViewModel = RMCharactersViewModel()
    
    weak var details: UIViewController!
    
    private(set) var bag = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        observeCharactersDataChanges()
        searchBar.delegate = self
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return charactersViewModel
            .characters
            .count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RMCharacterCell.identifier, for: indexPath) as! RMCharacterCell
        let characterRowUIModel = charactersViewModel.prepareCharacterFor(row: indexPath.row)
        
        setRMCharacterCell(cell, with: characterRowUIModel)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        charactersViewModel.userDidSelect(row: indexPath.row)
        presentDetailsController()
    }
    
    private func observeCharactersDataChanges() {
        charactersViewModel
            .$characters
            .removeDuplicates()
            .receive(on: DispatchQueue.main)
            .sink { _ in self.tableView.reloadData() }
            .store(in: &bag)
    }
    
    private func presentDetailsController() {
        if let detailViewController = details, let detailNavigationController = detailViewController.navigationController {
            splitViewController?
              .showDetailViewController(detailNavigationController, sender: nil)
        }
    }
    
    private func setRMCharacterCell(_ cell: RMCharacterCell, with uiModel: RMCharacterRowUIModel) {
        
        cell.nameLabel.text = uiModel.name
        cell.photoImageView.sd_setImage(with: uiModel.photoURL,
                                        placeholderImage: uiModel.placeholderImage,
                                        options: .scaleDownLargeImages, context: nil)
    }
}

extension RMCharactersMasterViewController: UISearchBarDelegate {

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        charactersViewModel.userDidSearchForCharacter(with: searchText)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        charactersViewModel.userDidFinishSearch()
        searchBar.resignFirstResponder()
    }
}
