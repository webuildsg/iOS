import UIKit
import MapKit
import EventKit
import SafariServices

class DetailTableViewController: UITableViewController, MKMapViewDelegate {

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
    var startDate: NSDate?
    var endDate: NSDate?
  
    private static let estimatedHeight: CGFloat = 80.0
    private static let numberOfRows = 6
    private static let numberOfSections = 1
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var openUrlButton: UIButton!
    @IBOutlet weak var byLabel: UILabel!
    @IBOutlet weak var byRepoLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    
    @IBAction func addToCalendarButton(sender: AnyObject) {
        let description = "Address: " + self.locationString! + "\n\n" + self.descriptionString!
        
        addEventToCalendar(title: self.titleString, description: description, startDate: self.startDate!, endDate: self.endDate!)
    }
    
    @IBAction func openUrl(sender: AnyObject) {
        let svc = SFSafariViewController(URL: NSURL(string: self.urlString)!)
        self.presentViewController(svc, animated: true, completion: nil)
    }
       
    override func viewDidLoad() {
        
        super.viewDidLoad()
        mapView.delegate = self
        
        tableView.separatorStyle = .None
        
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 193/255.0, green: 26/255.0, blue: 24/255.0, alpha: 1.0)
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        
        self.titleLabel.text = self.titleString
        self.descriptionLabel.text = self.descriptionString
        self.byLabel.text = self.byString
        self.byRepoLabel.text = self.byString
        self.dateLabel.text = self.dateString
        self.locationLabel.text = "📍 " + self.locationString!
        
        openUrlButton.setTitle(self.openUrlString, forState: .Normal)
        
        let initialLocation = CLLocation(latitude: self.latitudeValue, longitude: self.longitudeValue)
        let pin = Annotation(
            title: self.locationString!,
            location: self.locationString!,
            coordinate: CLLocationCoordinate2D(latitude: self.latitudeValue, longitude: self.longitudeValue))
        let note = MKPointAnnotation()
        
        note.coordinate = CLLocationCoordinate2D(latitude: self.latitudeValue, longitude: self.longitudeValue)
        note.subtitle = self.locationString!
        
        mapView.addAnnotation(pin)
        
        centerMapOnLocation(initialLocation)
    }
    
    func addEventToCalendar(title title: String, description: String?, startDate: NSDate, endDate: NSDate, completion: ((success: Bool, error: NSError?) -> Void)? = nil) {
        let eventStore = EKEventStore()
        
        eventStore.requestAccessToEntityType(.Event, completion: { (granted, error) in
            if (granted) && (error == nil) {
                let event = EKEvent(eventStore: eventStore)
                
                event.title = title
                event.startDate = startDate
                event.endDate = endDate
                event.notes = description
                event.calendar = eventStore.defaultCalendarForNewEvents
                
                do {
                    try eventStore.saveEvent(event, span: .ThisEvent)
                } catch let e as NSError {
                    completion?(success: false, error: e)
                    return
                }
                completion?(success: true, error: nil)
                
                let alert = UIAlertController(title: "Success", message: "Event added to your calendar!", preferredStyle: .Alert)
                let OKAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
                alert.addAction(OKAction)
                self.presentViewController(alert, animated: true, completion: nil)
                
            } else {
                completion?(success: false, error: error)
            }
        })
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

        if (self.typeString == "repos") {
            if (indexPath.row == 1 || indexPath.row == 3 || indexPath.row == 4) {
                // hide buttons, address, map
                return 0
            }
        }
        
        if (self.typeString == "events") {
            if (indexPath.row == 3 && self.latitudeValue == 1.3521 && self.longitudeValue == 103.8198) {
                // hide map section for events that does not have lat,long from the API info
                return 0
            }
            
            if (indexPath.row == 2) {
                // hide repository view code button
                return 0
            }
        }
        
        return UITableViewAutomaticDimension
    }
    
}
