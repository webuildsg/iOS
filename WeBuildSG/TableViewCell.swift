import UIKit

class TableViewCell: UITableViewCell {
    
    @IBOutlet weak var datetimeLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
