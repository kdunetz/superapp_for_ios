import MapKit

protocol LocationUpdateProtocol {
    func locationDidUpdateToLocation(location : CLLocation)
}

/// Notification on update of location. UserInfo contains CLLocation for key "location"
let kLocationDidChangeNotification = "LocationDidChangeNotification"

class UserLocationManager: NSObject, CLLocationManagerDelegate {
    
    static let SharedManager = UserLocationManager()
    
    private var locationManager = CLLocationManager()
    
    var currentLocation : CLLocation?
    
    var delegate : LocationUpdateProtocol!
    var locationChangedCounter: Int = 0
    
    private override init () {
        super.init()
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        //self.locationManager.startMonitoringSignificantLocationChanges;
        self.locationManager.pausesLocationUpdatesAutomatically = false;
        
        // NEEDED FOR BACKGROUND UPDATES locationManager!.allowsBackgroundLocationUpdates = true
        
        // NEEDED FOR BACKGROUND UPDATES locationManager!.pausesLocationUpdatesAutomatically = false
        if #available(iOS 9.0, *) {
            //self.locationManager.allowsBackgroundLocationUpdates = true
        } else {
            // Fallback on earlier versions
        };
        print("Starting Use Location Manager");
        self.locationManager.distanceFilter = 1
        if #available(iOS 8.0, *) {
            self.locationManager.requestAlwaysAuthorization()
            self.locationManager.requestWhenInUseAuthorization()
            print("IN HERE HERE UserLocationManager requestAlwaysAuthorization")
        } else {
            // Fallback on earlier versions
        }
        if CLLocationManager.authorizationStatus() != .authorizedAlways     // Check authorization for location tracking
        {
            print("not authorized yet")
            self.locationManager.requestAlwaysAuthorization()                    // LocationManager will callbackdidChange... once user responds
        } else {
            self.locationManager.startUpdatingLocation()
        }
}


    // MARK: - CLLocationManagerDelegate
    
    func locationManager(manager: CLLocationManager, didUpdateToLocation newLocation: CLLocation, fromLocation oldLocation: CLLocation) {
        currentLocation = newLocation
        let userInfo : NSDictionary = ["location" : currentLocation!]
        
        print ("IN HERE locationManager..UserLocationManager")
        DispatchQueue.main.async() { () -> Void in
            self.delegate.locationDidUpdateToLocation(location: self.currentLocation!)
            // KAD put generic Location Update code versus inside of MapController
            
            if (self.locationChangedCounter % 50 == 0)
            {
                let pf = PlayAroundFile()
                pf.playCloseDeals()
                pf.saveUserLocation()
                pf.makeGetCallArray(urlInput: "https://new-node-red-demo-kad.mybluemix.net/getAll?object_name=deal", callBackXX: PlayAroundFile.processDeals)
                pf.makeGetCallArray(urlInput: "https://new-node-red-demo-kad.mybluemix.net/getAll?object_name=object_one", callBackXX: PlayAroundFile.processUsers)
                
            }
            self.locationChangedCounter += 1
            NotificationCenter.default.post(name: Notification.Name(kLocationDidChangeNotification), object: self, userInfo: userInfo as [NSObject : AnyObject])
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print ("Error while updating location " + error.localizedDescription)
    }
    
    
    @nonobjc func locationManager(manager: CLLocationManager!, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        switch status
        {
        case .authorizedAlways:
            print("IN HERE authorized")
            locationManager.startUpdatingLocation()
            
        default:
            // User denied access, handle as appropriate
            print ("default")
        }
    }

}
