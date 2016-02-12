import UIKit

class NewViewController: UIViewController {
    
    var titleString: String!
    var dateString: String!
    var descriptionString: String!
    var urlString: String!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBAction func openUrl(sender: AnyObject) {
        UIApplication.sharedApplication().openURL(NSURL(string: self.urlString)!)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.titleLabel.text = self.titleString
        self.dateLabel.text = "on " + self.dateString
        self.descriptionLabel.text = self.descriptionString
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
        
}
