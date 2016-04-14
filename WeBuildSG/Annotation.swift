import Foundation
import MapKit

class Annotation: NSObject, MKAnnotation {
    let location: String
    let title: String?
    let coordinate: CLLocationCoordinate2D
    
    init(title: String, location: String, coordinate: CLLocationCoordinate2D) {
        self.title = location
        self.location = location
        self.coordinate = coordinate
        
        super.init()
    }
    
}
