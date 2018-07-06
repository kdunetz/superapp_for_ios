//
//  MapViewController.swift
//  SuperApp
//
//  Created by Kevin Dunetz on 6/4/18.
//  Copyright © 2018 Kevin Dunetz. All rights reserved.
//

import UIKit
import MapKit


@objc class MapViewController: UIViewController, MKMapViewDelegate, LocationUpdateProtocol {
    
    let regionRadius: CLLocationDistance = 5000
    var currentLocation : CLLocation!
    var desiredAccuracy:INTULocationAccuracy!
    var timeout:TimeInterval = 0.0
    var locationChangedCounter = 0
    var annotation: UserObject!
    var counter = 0
    
    var locationRequestID:INTULocationRequestID!

    @IBOutlet weak var mapView1: MKMapView!
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
                                                                  regionRadius, regionRadius)
        mapView1.setRegion(coordinateRegion, animated: true)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.mapView1.delegate = self


            let locationManager = CLLocationManager()

           // let initialLocation = CLLocation(latitude: Double((locationManager.location?.coordinate.latitude)!), longitude: Double((locationManager.location?.coordinate.longitude)!))
        let initialLocation = CLLocation(latitude: 38.79597475, longitude: -77.3640182)
        
            centerMapOnLocation(location: initialLocation)
           /*
            let artwork = UserObject(username: MyViewState.currentUser, title: MyViewState.currentUser,
                                  locationName: MyViewState.currentUser,
                                  discipline: "Sculpture",
                                  coordinate: CLLocationCoordinate2D(latitude: 38.79597475, longitude:  -77.3640182))
     
            mapView1.addAnnotation(artwork) */
     
        mapView1.mapType = .hybrid
        mapView1.isZoomEnabled = true
        if #available(iOS 9.0, *) {
            //mapView1.showsTraffic = true
        } else {
            // Fallback on earlier versions
        }

        NotificationCenter.default.addObserver(self, selector: #selector(MapViewController.locationUpdateNotification(_:)), name: NSNotification.Name(rawValue: kLocationDidChangeNotification), object: nil)
        
        let LocationMgr = UserLocationManager.SharedManager
        LocationMgr.delegate = self
        let locMgr:INTULocationManager = INTULocationManager.sharedInstance()

        locMgr.requestLocation(withDesiredAccuracy: .block, timeout: 10.0) {
            (currentLocation: CLLocation!, achievedAccuracy: INTULocationAccuracy, status: INTULocationStatus) in
            
            switch status {
                
            case .success:
                print("Success: \(currentLocation)")
                let pf = PlayAroundFile()
                pf.playCloseDeals()
            case .timedOut:
                print("Timed Out: \(currentLocation)")
            default:
                print("Error: \(status.rawValue)")
            }
        }
        
        self.startLocationUpdateSubscription()

        // Do any additional setup after loading the view.
    }
    //func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
    //    <#code#>
    //}
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        print("delegate called")
        
       // if !(annotation is CustomPointAnnotation) {
       //     return nil
       // }
        
        let reuseId = "test"
        
        
        var anView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId)
      
        if anView == nil {
            anView = MKAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            anView?.canShowCallout = true
        }
        else {
            anView?.annotation = annotation
            anView?.canShowCallout = true
        }
        
        //Set annotation-specific properties **AFTER**
        //the view is dequeued or created...
        
        //let cpa = annotation as CustomPointAnnotation
        let Identifier = UIDevice.current.identifierForVendor?.uuidString
        print ("ID = " + Identifier!)
        print("title = " + annotation.title!! as String)
        
        if (annotation.isMember(of: UserObject.self))
        {
            if (annotation.title == "ryandunetz@gmail.com") {
                anView?.image = UIImage(named:"ryandunetz.png")
            }
            else
            if (annotation.title == "rosadunetz@gmail.com") {
                anView?.image = UIImage(named:"rosadunetz.png")
            }
            else
            if (annotation.title == "andrewdunetz@gmail.com") {
                anView?.image = UIImage(named:"andrewdunetz.png")
            }
            else
            if (annotation.title == "kevindunetz@gmail.com") {
                anView?.image = UIImage(named:"kevindunetz.png")
            }
            else {
                anView?.image = UIImage(named:"person_48x48.png")
            }
        } else
        if (annotation.isMember(of: LocationObject.self))
        {
            anView?.image = UIImage(named:"iotlogo29x29.png");
        } else
        if (annotation.isMember(of: DealObject.self))
        {
            anView?.image = UIImage(named:"DollarSign_29x29.png");
        }
        
        return anView
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     *//*
     extension ViewController: MKMapViewDelegate {
     // 1
     func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
     // 2
     guard let annotation = annotation as? Artwork else { return nil }
     // 3
     let identifier = "marker"
     var view: MKMarkerAnnotationView
     // 4
     if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
     as? MKMarkerAnnotationView {
     dequeuedView.annotation = annotation
     view = dequeuedView
     } else {
     // 5
     view = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
     view.canShowCallout = true
     view.calloutOffset = CGPoint(x: -5, y: 5)
     view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
     }
     return view
     }
     }
     */
    
    func locationUpdateNotification(_ notification: Notification) {
        let userinfo = notification.userInfo
        self.currentLocation = userinfo!["location"] as! CLLocation
        print("Notification Latitude : \(self.currentLocation.coordinate.latitude)")
        print("Notification Longitude : \(self.currentLocation.coordinate.longitude)")
        if (counter == 0) {
           centerMapOnLocation(location: self.currentLocation)
            counter = counter + 1
        }
        let artwork = UserObject(username: MyViewState.currentUser, title: MyViewState.currentUser,
                              locationName: MyViewState.currentUser,
                              discipline: "Sculpture",
                              coordinate: CLLocationCoordinate2D(latitude: self.currentLocation.coordinate.latitude, longitude: self.currentLocation.coordinate.longitude))
 
        mapView1.addAnnotation(artwork)
        
    }
    
    // MARK: - LocationUpdateProtocol
    
    func locationDidUpdateToLocation( location: CLLocation) {
        currentLocation = location
        print("UpdateToLocation Latitude : \(self.currentLocation.coordinate.latitude)")
        print("UpdateToLocation Longitude : \(self.currentLocation.coordinate.longitude)")
        //centerMapOnLocation(location: self.currentLocation)
        let artwork = UserObject(username: MyViewState.currentUser, title: MyViewState.currentUser,
                              locationName: MyViewState.currentUser,
                              discipline: "Sculpture",
                              coordinate: CLLocationCoordinate2D(latitude: self.currentLocation.coordinate.latitude, longitude:  self.currentLocation.coordinate.longitude))
 
        mapView1.addAnnotation(artwork)
    }
    
    
    func startLocationUpdateSubscription() {
        weak var weakSelf = self
        let locMgr:INTULocationManager = INTULocationManager.sharedInstance()
        
        self.locationRequestID = locMgr.subscribeToLocationUpdates({ (currentLocation:CLLocation!, locationAccuracy:INTULocationAccuracy, locationStatus:INTULocationStatus) in
            
            weak var strongSelf = weakSelf
            
            if (locationStatus == INTULocationStatus.success) {
                // A new updated location is available in currentLocation, and achievedAccuracy indicates how accurate this particular location is
                //KAD strongSelf!.statusLabel.text = "'Location updates' subscription block called with Current Location:\(currentLocation)"

                let appDelegate = UIApplication.shared.delegate as! AppDelegate // THIS IS HOW YOU CALL A DELEGATE VARIABLE FROM SWIFT Class
                appDelegate.latestLocation = currentLocation

                print ("IN SUCCESS")
                
                let pf = PlayAroundFile()
                //pf.processLocationChanges()
                
                print(currentLocation)
                //self.centerMapOnLocation(location: currentLocation)
                if ((self.annotation) != nil) {
                    self.mapView1.removeAnnotation(self.annotation)
                }
                let artwork = UserObject(username: MyViewState.currentUser, title: MyViewState.currentUser,
                                      locationName: MyViewState.currentUser,
                                      discipline: "Sculpture",
                                      coordinate: CLLocationCoordinate2D(latitude: currentLocation.coordinate.latitude, longitude:  currentLocation.coordinate.longitude))
                self.annotation = artwork
                //let allAnnotations = self.mapView1.annotations
               

                self.mapView1.addAnnotation(artwork)
                self.locationChangedCounter =  self.locationChangedCounter + 1
                if (self.locationChangedCounter % 50 == 0)
                {
                    //pf.playCloseDeals()
                    //pf.saveUserLocation()
                    //pf.makeGetCallArray(urlInput: "https://new-node-red-demo-kad.mybluemix.net/getAll?object_name=deal", callBackXX: PlayAroundFile.processDeals)
                    //pf.makeGetCallArray(urlInput: "https://new-node-red-demo-kad.mybluemix.net/getAll?object_name=object_one", callBackXX: PlayAroundFile.processUsers)
                    
                    
                    let users = pf.getUsers()
                    for anItem in users as! [Dictionary<String, Any>]  {  // or [[String:Any]]
                        print ("Display Users")
                        if anItem["username"] != nil && anItem["latitude"] != nil && anItem["longitude"] != nil {
                            let username = anItem["username"] as! String
                            let latitude = anItem["latitude"] as! String
                            let longitude = anItem["longitude"] as! String
                            if latitude.count > 0 && longitude.count > 0 && username != MyViewState.currentUser
                            {
                                let artwork = UserObject(username: username, title: username,
                                                      locationName: latitude + "," + longitude,
                                                      discipline: "Sculpture",
                                                      coordinate: CLLocationCoordinate2D(latitude: Double(latitude)!, longitude:  Double(longitude)!))
                                self.mapView1.addAnnotation(artwork)
                                print("printing users")
                            }
                            else
                            {
                                print(username + " has empty latitude or longitude")
                            }
                        }
                    }
                }
                // PROCESS COUPON ALERTS
                if (self.locationChangedCounter % 1 == 0)
                {
                    let deals = pf.getDeals()
                    print ("Processing Coupon Alerts")
                    for deal in deals as! [Dictionary<String, Any>]  {  // or [[String:Any]]
                        
                        if deal["username"] == nil || deal["deal"] == nil || deal["latitude"] == nil || deal["longitude"] == nil || deal["coupon_expiration_days"] == nil || deal["coupon_expiration_days"] == nil {
                            continue;
                        }
                        let dealUserName = deal["username"] as! String
                        let dealText = deal["deal"] as! String
                        let dealId = deal["_id"] as! String
                        print ("Made it here + " + dealId)
                        
                        if (MyViewState.currentUser != dealUserName) {
                            continue;
                       }
                      
                        let days = deal["coupon_expiration_days"] as! String
                        let date = deal["date"] as! String
                        let dealCompanyName = deal["company_name"] as! String
                        
                        print ("Checking deals for " + dealCompanyName);
                        if pf.couponActive(date: date, days: days) {
                      
                            print ("Found active deal for " + dealCompanyName)
                           
                            let localBusinesses = MyViewState.localBusinesses
                            print ("Processing Local Businesses")
                            
                            for localBusiness in localBusinesses as! [Dictionary<String, Any>]  {  // or [[String:Any]]
                                if localBusiness["name"] != nil && localBusiness["latitude"] != nil && localBusiness["longitude"] != nil {
                                    let localBusinessId = localBusiness["id"] as! String
                                    let localBusinessName = localBusiness["name"] as! String
                                    let latitude = localBusiness["latitude"] as! Double
                                    let longitude = localBusiness["longitude"] as! Double
                    
                                    print ("Found deal 1" + localBusinessName)
                                    
                                
                                    print ("Found deal before if statements :" + localBusinessName + "," + dealCompanyName + "," + dealUserName + "," + MyViewState.currentUser)
                                    
                                    if (!self.companyNameMatch(companyName: dealCompanyName,  name: localBusinessName)) {
                                        print("companyMatch failed: " + dealCompanyName + "," + localBusinessName)
                                        continue
                                    }
                                    
                                    print ("Found deal before if statements :" + localBusinessName + "," + dealCompanyName + "," + dealUserName + "," + MyViewState.currentUser)
                                    
                                    
                                    let dealLocation = CLLocation(latitude: latitude , longitude:  longitude )
                                    let distance = pf.distanceBetween(location1: currentLocation, location2: dealLocation) as Double
                                    print("distance = %d, %s", distance, dealText, currentLocation)
                                   // let message = "Looking for close " + name + " - " +
                                     //   "," + distance + "," + latitude + "," + longitude
                                    
                                    //print (message)
                                    
                                    if ((distance < Double(MyViewState.couponAlertDistance)) && (MyViewState.couponHash[dealId+localBusinessId] == false || MyViewState.couponHash[dealId+localBusinessId] == nil)) { // 200
                                        //if (anItem["playOnFrontSide"] != nil) {
                                        
                                        print("SPEAKING " + dealText)
                                        if (deal.count < Int(MyViewState.maxDealLength)) {
                                            pf.speakWords(words: dealCompanyName + " is near. You have a coupon." + dealText);
                                        }
                                        //}
                                        MyViewState.couponHash[dealId+localBusinessId] = true;
                                    }
                                    if (distance > Double(MyViewState.couponAlertDistance) && MyViewState.couponHash[dealId+localBusinessId] == true) { //200
                                        //if (anItem["playOnBackSide"] != nil) {
                                        print("SPEAKING " + dealText)
                                        if (deal.count < Int(MyViewState.maxDealLength)) {
                                            pf.speakWords(words: dealCompanyName + " is near. You have a coupon.");
                                        }
                                        // }
                                        MyViewState.couponHash[dealId+localBusinessId] = false;
                                        
                                    }
                                }
                                else
                                {
                                    print("has empty latitude or longitude")
                                }
                            }// loop for localBusinesses
                        } // couponActive
                    } // for loop for deals
                } // end of if
                // DISPLAY DEALS ON MAP
                if (self.locationChangedCounter % 5 == 0)
                {
                    let deals = pf.getDeals()
                    for anItem in deals as! [Dictionary<String, Any>]  {  // or [[String:Any]]
                        print ("Display Deals")
                        //if anItem["company_name"] != nil && anItem["latitude"] != nil && anItem["longitude"] != nil {
                        
                        //let companyName = anItem["company_name"] as! String
                        if anItem["deal"] != nil && anItem["latitude"] != nil && anItem["longitude"] != nil {
                            let deal = anItem["deal"] as! String
                            let latitude = anItem["latitude"] as! String
                            let longitude = anItem["longitude"] as! String
                            if latitude.count > 0 && longitude.count > 0
                            {
                                let artwork = DealObject(title: deal, type: "coupon",
                                                      locationName: deal,
                                                      discipline: "Sculpture",
                                                      coordinate: CLLocationCoordinate2D(latitude: Double(latitude)!, longitude:  Double(longitude)!))
                                self.mapView1.addAnnotation(artwork)
                                print("printing deals")
                            }
                            else
                            {
                                print(deal + " has empty latitude or longitude")
                        
                            }
                        }
                    }
                }
                if (self.locationChangedCounter % 5 == 0)
                {
                        let appDelegate = UIApplication.shared.delegate as! AppDelegate // THIS IS HOW YOU CALL A DELEGATE VARIABLE FROM SWIFT Class
                        let location = appDelegate.latestLocation
                        let couponCompanies = MyViewState.couponCompanies
                    pf.printJSON(obj: couponCompanies)
                    for key in couponCompanies.keys {
                        
                        print ("key = " + key)
                        if (true)
                        {
                            let latitude = String(format:"%.9f", (location?.coordinate.latitude)!) as String
                            let longitude = String(format:"%.9f", (location?.coordinate.longitude)!) as String
                            
                            let  company = key.replacingOccurrences(of: " ", with: "%20") as String
                            let pf = PlayAroundFile()
                            var url = "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=" + latitude + "," + longitude
                            url = url + "&radius=" + String(MyViewState.localBusinessSearchRadius)
                            url = url + "&keyword=" + company + "&key=AIzaSyDCDhTlu3ZBZ3BvtgUbQfS1DqHdPWCWzzk"
                            pf.makeGetCall(urlInput: url , callBackXX: self.processLocalBusinesses)
                        }
                    }
                    
                } // end of locationChangedCounter
            }
            else {
                // An error occurred
                //KAD strongSelf!.statusLabel.text = strongSelf?.getLocationErrorDescription(locationStatus)
                print ("IN FAILURE")
            }
        
        })
    }
    public func companyNameMatch(companyName: String, name: String) -> Bool
    {
        let name = name.uppercased().replacingOccurrences(of: "'", with: "").replacingOccurrences(of: "-", with: " ")
        let companyName = companyName.uppercased().replacingOccurrences(of: "'", with: "").replacingOccurrences(of: "-", with: " ")
        if (name == companyName)  {
            return true
        }
        
        if (name.contains(companyName)) {
            return true
        }
        
        if (companyName.contains(name)) {
            return true
        }
        return false
    }
    public func processLocalBusinesses(json: [String: Any]) -> Void
    {
        MyViewState.localBusinesses = []
        let pf = PlayAroundFile()
        //pf.printJSON(obj: json)
        let location = json["results"]
        //print (location)
        //pf.printJSON(obj: location)
        var localBusiness: [String:Any] = [:]
        for anItem in location as! [Dictionary<String, Any>]  {  // or [[String:Any]]
            //print ("Looping through Locations")
            let geometry = anItem["geometry"] as! [String: Any]
            let name = anItem["name"]
            let id = anItem["id"]
            //pf.printJSON(obj: geometry)
            let location = geometry["location"] as! [String: Any]
            //pf.printJSON(obj: location)
            let latitude = location["lat"] as! Double
            let longitude = location["lng"] as! Double
            localBusiness["id"] = id
            localBusiness["name"] = name
            localBusiness["latitude"] = latitude
            localBusiness["longitude"] = longitude
            let artwork = LocationObject(title: name as! String, type: "Local Business",
                                         locationName: name as! String,
                                     discipline: "Sculpture",
                                     coordinate: CLLocationCoordinate2D(latitude: latitude, longitude: longitude))
            
            mapView1.addAnnotation(artwork)
            MyViewState.localBusinesses.append(localBusiness)
        }
        /*
 {
 geometry =     {
 location =         {
 lat = "38.9367424";
 lng = "-77.18377769999999";
 };
 viewport =         {
 northeast =             {
 lat = "38.93796737989272";
 lng = "-77.18251927010728";
 
 };
 southwest =             {
 lat = "38.93526772010728";
 lng = "-77.18521892989273";
 };
 };
 };
 icon = "https://maps.gstatic.com/mapfiles/place_api/icons/restaurant-71.png";
 id = f571423c08ace6d1d0eeed8974d676049d4ad36e;
 name = "McDonald's";
 "opening_hours" =     {
 "open_now" = 1;
 };
*/
        
    }
    
}

