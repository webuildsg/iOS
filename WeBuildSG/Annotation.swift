import Foundation
import MapKit

class Annotation: NSObject, MKAnnotation {
    let location: String
    let coordinate: CLLocationCoordinate2D
    
    init(location: String, coordinate: CLLocationCoordinate2D) {
        self.location = location
        self.coordinate = coordinate
        
        super.init()
    }
    
}
