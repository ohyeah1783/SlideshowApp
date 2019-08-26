import UIKit

protocol DetailDelegate {
    func closedDetailView()
}

class DetailViewController: UIViewController {
    
    var delegate: DetailDelegate?
    
    @IBOutlet weak var imageView: UIImageView!
    var image: UIImage?

    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.image = image
    }
    
    @IBAction func handleBack(_ sender: Any) {
        delegate?.closedDetailView()
        dismiss(animated: true, completion: nil)
    }
    
    
}
