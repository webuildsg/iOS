import UIKit

class NewViewController: UIViewController {
    
    var titleString: String!
    var dateString: String!
    var descriptionString: String!
    var urlString: String!
    var typeString: String!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var openUrlButton: UIButton!
    @IBAction func openUrl(sender: AnyObject) {
        UIApplication.sharedApplication().openURL(NSURL(string: self.urlString)!)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if (self.typeString == "events") {
            openUrlButton.setTitle("Register for event", forState: .Normal)
        } else {
            openUrlButton.setTitle("View code", forState: .Normal)
        }
        
        self.titleLabel.text = self.titleString
        self.dateLabel.text = "on " + self.dateString
        self.descriptionLabel.text = self.descriptionString
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
        
}
