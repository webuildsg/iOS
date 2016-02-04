import UIKit

class NewViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    var titleString: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.titleLabel.text = self.titleString
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
        
}
