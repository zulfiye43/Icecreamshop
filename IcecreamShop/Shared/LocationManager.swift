import Foundation
import MapKit
import CoreLocation
import Combine

class LocationManager: NSObject, ObservableObject {
    // CLGeocoder is location decoder/encoder interface.
    lazy var geocoder = CLGeocoder()
    
    @Published var invalid: Bool = false // Unnecessary flag, but it's mission is controlling error states
   
    func openMapWithAddress (_ locationString: String) {
        // location string to latitude and longitude. Example: "675 Watertown St, Watertown St, Newton, United States" => lat: 42.3548226, long: -71.212563
        geocoder.geocodeAddressString(locationString) { placemarks, error in
            // if location string is invalid, throw error and prevent process
            if let error = error {
                DispatchQueue.main.async {
                    self.invalid = true
                }
                print(error.localizedDescription)
            }
            // get first placemark from all possible locations
            guard let placemark = placemarks?.first else {
                return
            }
            
            // location string to latitude
            guard let lat = placemark.location?.coordinate.latitude else{return}
            
            // location string to longitude
            guard let lon = placemark.location?.coordinate.longitude else{return}
            
            // FOR: Create Location Object with given Coordinates
            let coords = CLLocationCoordinate2DMake(lat, lon)
            
            // FOR: Create Location Object with given Coordinates
            let place = MKPlacemark(coordinate: coords)
            
            // FOR: Create MKMapItem Object with given Placemark Object
            let mapItem = MKMapItem(placemark: place)
            mapItem.name = locationString
            mapItem.openInMaps(launchOptions: nil) // FOR: Launch map with given address
        }
        
    }
}
