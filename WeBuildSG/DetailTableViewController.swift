import UIKit
import MapKit

class DetailTableViewController: UITableViewController {

    var titleString: String!
    var dateString: String!
    var descriptionString: String!
    var urlString: String!
    var openUrlString: String!
    var typeString: String!
    var byString: String!
    var latitudeValue: Double!
    var longitudeValue: Double!
    var locationString: String?
  
    private static let estimatedHeight: CGFloat = 80.0
    private static let numberOfRows = 4
    private static let numberOfSections = 1

    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var openUrlButton: UIButton!
    @IBOutlet weak var byLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    
    @IBAction func openUrl(sender: AnyObject) {
        UIApplication.sharedApplication().openURL(NSURL(string: self.urlString)!)
    }
       
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        tableView.separatorStyle = .None
        
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 193/255.0, green: 26/255.0, blue: 24/255.0, alpha: 1.0)
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        
        self.titleLabel.text = self.titleString
        self.descriptionLabel.text = self.descriptionString
        self.byLabel.text = self.byString
        self.dateLabel.text = self.dateString
        
        openUrlButton.setTitle(self.openUrlString, forState: .Normal)
        
        let initialLocation = CLLocation(latitude: self.latitudeValue, longitude: self.longitudeValue)
        let pin = Annotation(
            location: self.locationString!,
            coordinate: CLLocationCoordinate2D(latitude: self.latitudeValue, longitude: self.longitudeValue))
        let note = MKPointAnnotation()
        
        note.coordinate = CLLocationCoordinate2D(latitude: self.latitudeValue, longitude: self.longitudeValue)
        note.subtitle = self.locationString!
        
        mapView.addAnnotation(note)
        mapView.addAnnotation(pin)
        centerMapOnLocation(initialLocation)
        
    }
    
    let regionRadius: CLLocationDistance = 1000
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, regionRadius * 2.0, regionRadius * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return DetailTableViewController.numberOfSections
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DetailTableViewController.numberOfRows
    }
  
    override func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return DetailTableViewController.estimatedHeight
    }
  
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {

        if (self.typeString == "repos" && indexPath.row == 2) {
            return 0 // hide map section for repositories
        } else {
            return UITableViewAutomaticDimension
        }
    }
    
}
