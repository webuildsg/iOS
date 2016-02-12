import UIKit

class NewViewController: UIViewController {
    
    var titleString: String!
    var dateString: String!
    var descriptionString: String!
    var urlString: String!
    var typeString: String!
    var byString: String!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var byLabel: UILabel!
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
        self.titleLabel.textColor = UIColor(red: 34/255.0, green: 141/255.0, blue: 183/255.0, alpha: 1.0)
        self.dateLabel.text = "on " + self.dateString
        self.descriptionLabel.text = self.descriptionString
        self.byLabel.text = "by " + self.byString
        
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
        
}
