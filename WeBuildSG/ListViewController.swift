import UIKit

class ListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var loader: UIActivityIndicatorView!
    
    var sections: [Section] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loader.startAnimating()
        loader.hidesWhenStopped = true
        
        let control = UIRefreshControl()
        control.addTarget(self, action: #selector(ListViewController.refreshData(_:)), forControlEvents: .ValueChanged)
        self.tableView.addSubview(control)
        
        self.tableView.estimatedRowHeight = self.tableView.rowHeight
        self.tableView.rowHeight = UITableViewAutomaticDimension
        
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 193/255.0, green: 26/255.0, blue: 24/255.0, alpha: 1.0)
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        
        getData()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ListViewController.onContentSizeChanged), name: UIContentSizeCategoryDidChangeNotification, object: nil)
        
    }
    
    deinit{
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    
    func getData() {
        SectionsData().getSectionsFromData({
            sections in
            
            self.loader.stopAnimating()
            self.sections = sections
            self.tableView.reloadData()
        })
    }
    
    func refreshData(refreshControl: UIRefreshControl) {
        SectionsData().getSectionsFromData({
            sections in
            
            self.sections = sections
            self.tableView.reloadData()
            refreshControl.endRefreshing()
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section].heading
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].objects.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as? TableViewCell
        
        cell?.titleLabel.text = sections[indexPath.section].objects[indexPath.row].name
        
        let type = sections[indexPath.section].objects[indexPath.row].type
        let date = sections[indexPath.section].objects[indexPath.row].date
        
        if (type == "events") {
            cell!.datetimeLabel!.text = "on " + date
        } else {
            cell!.datetimeLabel!.text = "updated " + date
        }
        
        cell?.titleLabel.font = UIFont.preferredFontForTextStyle(UIFontTextStyleHeadline)
        cell?.datetimeLabel.font = UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)
        
        return cell!
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        self.tableView.backgroundColor = UIColor.whiteColor()
        let headerFrame = tableView.frame
        
        let title = UILabel()
        title.frame =  CGRectMake(10, 30, headerFrame.size.width-20, 40)
        title.font = UIFont(name: "Futura", size: 30)!
        title.text = self.tableView(tableView, titleForHeaderInSection: section)
        title.textColor = UIColor(red: 34/255.0, green: 141/255.0, blue: 183/255.0, alpha: 1.0)
        
        let headerView:UIView = UIView(frame: CGRectMake(0, 0, headerFrame.size.width, headerFrame.size.height))
        headerView.addSubview(title)
        
        return headerView
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 100
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.performSegueWithIdentifier("showDetail", sender: self)
        self.tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail" {
            let indexPath = self.tableView.indexPathForSelectedRow!
            let backItem = UIBarButtonItem()
            let upcoming = segue.destinationViewController as! DetailTableViewController
            
            upcoming.titleString = sections[indexPath.section].objects[indexPath.row].name
            upcoming.typeString = sections[indexPath.section].objects[indexPath.row].type
            upcoming.descriptionString = sections[indexPath.section].objects[indexPath.row].description
            upcoming.urlString = sections[indexPath.section].objects[indexPath.row].url
            upcoming.byString = "by " + sections[indexPath.section].objects[indexPath.row].by
            upcoming.latitudeValue = sections[indexPath.section].objects[indexPath.row].latitude
            upcoming.longitudeValue = sections[indexPath.section].objects[indexPath.row].longitude
            upcoming.locationString = sections[indexPath.section].objects[indexPath.row].location
            
            if (upcoming.typeString == "events") {
                upcoming.dateString = "on " + sections[indexPath.section].objects[indexPath.row].date
                upcoming.openUrlString = "RSVP event"
                upcoming.startDate = sections[indexPath.section].objects[indexPath.row].start
                upcoming.endDate = sections[indexPath.section].objects[indexPath.row].end
            } else {
                upcoming.dateString = "updated " + sections[indexPath.section].objects[indexPath.row].date
                upcoming.openUrlString = "View code"
            }
            
            backItem.title = "Back"
            navigationItem.backBarButtonItem = backItem
        }
    }
    
    func onContentSizeChanged(){
        self.tableView.reloadData()
    }

}

