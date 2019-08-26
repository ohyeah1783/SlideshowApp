import UIKit

class SlideViewController: UIViewController, DetailDelegate{
    
    // UI components
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var playButton: UIButton!
    
    let slide01 = UIImage(named: "slide01.jpg")
    let slide02 = UIImage(named: "slide02.jpg")
    let slide03 = UIImage(named: "slide03.jpg")
    let slide04 = UIImage(named: "slide04.jpg")
    
    fileprivate lazy var images = [slide01, slide02, slide03, slide04]
    fileprivate var nextIndex = 0
    fileprivate var isPlaying = false
    fileprivate var timer: Timer!
    fileprivate var total: TimeInterval = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    fileprivate func setupView(){
        setImage(index: nextIndex)
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleImageTap(_:))))
    }
    
    @IBAction func handleBack(_ sender: Any) {
        showPreviousImage()
    }
    
    fileprivate func showPreviousImage(){
        if nextIndex == 0 {
            nextIndex = images.count - 1
        } else{
            nextIndex -= 1
        }
        setImage(index: nextIndex)
    }
    
    
    @IBAction func handleImageTap(_ sender: Any) {
        timer?.invalidate()
        performSegue(withIdentifier: "detailViewController", sender: nil)
    }
    
    @IBAction func handleNext(_ sender: Any) {
        showNextImage()
    }
    
    fileprivate func showNextImage(){
        if nextIndex == images.count - 1 {
            nextIndex = 0
        } else {
            nextIndex += 1
        }
        setImage(index: nextIndex)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let detailViewController = segue.destination as? DetailViewController
        detailViewController?.delegate = self
        detailViewController?.image = images[nextIndex]
    }
    
    @IBAction func handlePlay(_ sender: Any) {
        if isPlaying {
            timer?.invalidate()
            playButton.setTitle("再生", for: .normal)
        } else {
            startTimer()
            playButton.setTitle("停止", for: .normal)
        }
        backButton.isEnabled = isPlaying
        nextButton.isEnabled = isPlaying
        isPlaying = !isPlaying
    }
    
    @objc fileprivate func timerUpdate(_ sender: Timer){
        total += sender.timeInterval
        if Int(total) % 2 == 0 {
            showNextImage()
        }
    }
    
    fileprivate func setImage(index: Int) {
        imageView.image = images[index]
    }
    
    func closedDetailView() {
        if isPlaying {
            startTimer()
        }
    }
    
    fileprivate func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerUpdate(_:)), userInfo: nil, repeats: true)
    }


}

