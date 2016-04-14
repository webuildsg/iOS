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
        
                
        self.tableView.estimatedRowHeight = 80
        self.tableView.rowHeight = UITableViewAutomaticDimension
//        self.tableView.setNeedsLayout()
//        self.tableView.layoutIfNeeded()
        
        tableView.separatorStyle = .None
        
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 193/255.0, green: 26/255.0, blue: 24/255.0, alpha: 1.0)
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        
        self.titleLabel.text = self.titleString
        self.descriptionLabel.text = self.descriptionString
        self.byLabel.text = self.byString
        self.dateLabel.text = self.dateString
        
        openUrlButton.setTitle(self.openUrlString, forState: .Normal)
        
        let initialLocation = CLLocation(latitude: self.latitudeValue, longitude: self.longitudeValue)
        let note = Annotation(
            location: self.locationString!,
            coordinate: CLLocationCoordinate2D(latitude: self.latitudeValue, longitude: self.longitudeValue))
        
        centerMapOnLocation(initialLocation)
        mapView.addAnnotation(note)
            
    }
    
    let regionRadius: CLLocationDistance = 1000
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
                                                                  regionRadius * 2.0, regionRadius * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
//    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
//        print(indexPath)
//        return UITableViewAutomaticDimension
//    }

    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
