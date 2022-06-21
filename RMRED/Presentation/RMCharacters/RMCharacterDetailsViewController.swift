import UIKit

class RMCharacterDetailsViewController: UIViewController {
    
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var speciesLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var currentLocationLabel: UILabel!
    
    var rmCharacter: RMCharacterUIModel? {
        didSet {
            DispatchQueue.main.async {
                guard let rmCharacter = self.rmCharacter else {
                    return
                }
                self.loadViewIfNeeded()
                self.photoImageView.sd_setImage(with: rmCharacter.photoURL,
                                                placeholderImage: rmCharacter.placeholderImage,
                                                options: .fromCacheOnly, context: nil)
                self.nameLabel.text = rmCharacter.name
                self.statusLabel.text = rmCharacter.status
                self.speciesLabel.text = rmCharacter.species
                self.genderLabel.text = rmCharacter.gender
                self.currentLocationLabel.text = rmCharacter.location
            }
        }
    }
}
