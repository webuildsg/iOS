import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var sections: [Section] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.estimatedRowHeight = self.tableView.rowHeight
        self.tableView.rowHeight = UITableViewAutomaticDimension
        
        SectionsData().getSectionsFromData({
            sections in
            
            self.sections = sections
            self.tableView.reloadData()
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
    
    func tableView(tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        self.tableView.backgroundColor = UIColor.whiteColor()
        
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.font = UIFont(name: "Futura", size: 30)!
        header.textLabel?.textColor = UIColor(red: 34/255.0, green: 141/255.0, blue: 183/255.0, alpha: 1.0)
        header.textLabel?.textAlignment = NSTextAlignment.Center
    }
    
    // Table view
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as? TableViewCell
        
        cell!.titleLabel!.text = sections[indexPath.section].objects[indexPath.row].name
        cell!.datetimeLabel!.text = "on " + sections[indexPath.section].objects[indexPath.row].date
        
        return cell!
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 120
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.performSegueWithIdentifier("showView", sender: self)
    }
    
    // Detail view
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "showView") {
            let upcoming: NewViewController = segue.destinationViewController as! NewViewController
            
            let indexPath = self.tableView.indexPathForSelectedRow!
            let titleString = sections[indexPath.section].objects[indexPath.row].name
            let dateString = sections[indexPath.section].objects[indexPath.row].date
            let descriptionString = sections[indexPath.section].objects[indexPath.row].description
            let urlString = sections[indexPath.section].objects[indexPath.row].url
            let typeString = sections[indexPath.section].objects[indexPath.row].type
            
            upcoming.titleString = titleString
            upcoming.dateString = dateString
            upcoming.descriptionString = descriptionString
            upcoming.urlString = urlString
            upcoming.typeString = typeString
            
            self.tableView.deselectRowAtIndexPath(indexPath, animated: true)
        }
    }
    
}

