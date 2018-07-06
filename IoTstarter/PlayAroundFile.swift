//
//  PlayAroundFile.swift
//  IoTstarter
//
//  Created by Kevin Dunetz on 6/5/18.
//  Copyright © 2018 Mike Robertson. All rights reserved.
//

import Foundation
import AVFoundation
//import Cocoa

var deals: [Dictionary<String, Any>] = []
var users: [Dictionary<String, Any>] = []
var appUser: [String: AnyObject] = [:]
var hasher: [String: Bool] = [:]
var locationChangedCounter =  0;

@objc public class PlayAroundFile : NSObject {
    /*
    class func new() -> PlayAroundFile {
        return PlayAroundFile()
    }*/
    override init () {
    }
    public func getUsers() -> [Dictionary<String, Any>]
    {
        return users
    }
    public func speakWords(words: String)
    {
        print ("in SPEAK WORDS")
        let synth = AVSpeechSynthesizer()
        let myUtterance = AVSpeechUtterance(string: words)
        myUtterance.volume = 1.0
        myUtterance.voice = AVSpeechSynthesisVoice(language: "en-US")
        
        synth.speak(myUtterance)
    }
    public func initSuperApp()
    {
        let synth = AVSpeechSynthesizer()
        let myUtterance = AVSpeechUtterance(string: "Initializing Super App")
        myUtterance.voice = AVSpeechSynthesisVoice(language: "en-US")

        myUtterance.volume = 1.0
        synth.speak(myUtterance)
        
      
        //makeGetCall(urlInput: "https://jsonplaceholder.typicode.com/todos/1", callBackXX: PlayAroundFile.testCallBack)
        makeGetCallArray(urlInput: "https://new-node-red-demo-kad.mybluemix.net/getAll?object_name=deal", callBackXX: PlayAroundFile.processDeals)
        makeGetCallArray(urlInput: "https://new-node-red-demo-kad.mybluemix.net/getAll?object_name=object_one", callBackXX: PlayAroundFile.processUsers)
      

        /* TEST CODE WHICH WORKS
        var json = "{\"deal\":\"Hello There\",\"latitude\":\"223423\"}"
        print(json)
        makePostCall(urlInput: "https://new-node-red-demo-kad.mybluemix.net/save?object_name=deal", json: json, callBackXX: PlayAroundFile.saveDeal)
        
         */
let strBase64 = "R0lGODlhAQABAIAAAAUEBAAAACwAAAAAAQABAAACAkQBADs="
        let json = "{\n" +
            "  \"requests\": [\n" +
            "    {\n" +
            "      \"image\": {\n" +
            "        \"content\": \"" + strBase64 + "\"\n" +
            "      },\n" +
            "      \"features\": [\n" +
            "        {\n" +
            "          \"type\": \"TEXT_DETECTION\"\n" +
            "        }\n" +
            "      ]\n" +
            "    }\n" +
            "  ]\n" +
        "}";
        print (json)
        //makePostCall(urlInput: "https://vision.googleapis.com/v1/images:annotate?key=AIzaSyBESW49t48CGrcITU7-V34PeQkWAoOeBYM", json: json, callBackXX: PlayAroundFile.processImageResult)

        print("IN HERE speak")
        //var receipt: Receipt = parseOutReceipt(value: "HELLO MCD http://www.kevin.com BURGER KING 0000-1111-2222-3333-4444 within 3 days 10/24/1967")
        //print (receipt)
        let Identifier = UIDevice.current.identifierForVendor?.uuidString
        print ("ID = " + Identifier!)
       
            if (Identifier == "DAD1C6A9-E168-4843-8D81-024EB0A3EB0C") {
                MyViewState.currentUser = "andrewdunetz@gmail.com"
            }
            else if (Identifier == "EB4BFDB6-DD6D-4ECE-85B8-9355313F4007") {
                MyViewState.currentUser = "rosadunetz@gmail.com"
            }
            else
            {
                MyViewState.currentUser = "ryandunetz@gmail.com"
            }

        
          makeGetCallArray(urlInput: "https://new-node-red-demo-kad.mybluemix.net/authenticate?username=%22" + MyViewState.currentUser + "%22", callBackXX: PlayAroundFile.processUserResult)
    }
    class public func processImageResult(json: [String: Any]) -> Void
    {
        //let appDelegate = UIApplication.shared.delegate as! AppDelegate // THIS IS HOW YOU CALL A DELEGATE VARIABLE FROM SWIFT Class
        //appDelegate.deals = json
        //deals = json
        //MyViewState.deals = json
        print (" in process Image Result")
        print(json)
        //let json = JSON(data: json)
    }
    class public func saveUser(json: [String: Any]) -> Void
    {
        let pf = PlayAroundFile()
        pf.makeGetCallArray(urlInput: "https://new-node-red-demo-kad.mybluemix.net/authenticate?username=%22" + MyViewState.currentUser + "%22", callBackXX: PlayAroundFile.processUserResult)
    }
    class public func processLocalBusinesses(json: [String: Any]) -> Void
    {
        let pf = PlayAroundFile()
        pf.printJSON(obj: json)
        
    }
    public func sendImageToGoogle()
    {
      
        var jsonString = ""
        //makePostCall(urlInput: "https://vision.googleapis.com/v1/images:annotate?key=AIzaSyBESW49t48CGrcITU7-V34PeQkWAoOeBYM", json: jsonString, callBackXX: PlayAroundFile.processImageResult)

    }
    class public func testCallBack(json: [String: AnyObject]) -> Void
    {
        guard let todoTitle = json["title"] as? String else {
            print("Could not get todo title from JSON")
            return
        }
        print("Callback called: title = " + (json["title"] as? String)!)
    }
    class public func processUserResult(json: [Dictionary<String, Any>]) -> Void
    {
      //  appUser = json
        for anItem in json as! [Dictionary<String, Any>]  {
            appUser = anItem as [String : AnyObject]
            MyViewState.currentUser = (anItem["username"] as? String)!
            print("CurrentUser = " + MyViewState.currentUser)
        }
    
        print("Callback called: user = " + (appUser["username"] as? String)!)
        print("Callback called: latitude = " + (appUser["latitude"] as? String)!)
     
        if let theJSONData = try?  JSONSerialization.data(
            withJSONObject: appUser,
            options: .prettyPrinted
            ),
            let theJSONText = String(data: theJSONData,
                                     encoding: String.Encoding.ascii) {
            print("JSON string = \n\(theJSONText)")
        }
        if (false) {// just put a loopback in here for testing
            let pf = PlayAroundFile()
            //pf.saveUserLocation()
        
        }
    }
    public func printJSON(obj : Any)
    {
        if let theJSONData = try?  JSONSerialization.data(
            withJSONObject: obj,
            options: .prettyPrinted
            ),
            let theJSONText = String(data: theJSONData,
                                     encoding: String.Encoding.ascii) {
            print("JSON string = \n\(theJSONText)")
            
        }
    }
    
    public func playDeals()
    {
        print ("IN playDeals")
        for anItem in deals as! [Dictionary<String, Any>]  {
            if anItem["deal"] != nil {
                speakWords(words: anItem["deal"] as! String);
            }
        }
    }
    public func getDeals() -> [Dictionary<String, Any>]
    {
        return deals;
    }
    public func saveUserLocation()
    {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate // THIS IS HOW YOU CALL A DELEGATE VARIABLE FROM SWIFT Class
        let location = appDelegate.latestLocation
        appUser["latitude"] = String(format:"%.9f", (location?.coordinate.latitude)!) as AnyObject
        appUser["longitude"] = String(format:"%.9f", (location?.coordinate.longitude)!) as AnyObject
        //
        //print(json)
        if let theJSONData = try?  JSONSerialization.data(
            withJSONObject: appUser,
            options: .prettyPrinted
            ),
            let theJSONText = String(data: theJSONData,
                                     encoding: String.Encoding.ascii) {
            print("JSON string = \n\(theJSONText)")
            makePostCall(urlInput: "https://new-node-red-demo-kad.mybluemix.net/save?object_name=object_one", json: theJSONText, callBackXX: PlayAroundFile.saveUser)
            
        }
        

    }
    public func processLocationChanges()
    {
     print("IN HERE KEVIN")
        if (locationChangedCounter % 5 == 0)
        {
            playCloseDeals()
        }
        if (locationChangedCounter % 5 == 0)
        {
            saveUserLocation()
        }
    }
    public func playCloseDeals()
    {
        print("in playCloseDeals")
        let appDelegate = UIApplication.shared.delegate as! AppDelegate // THIS IS HOW YOU CALL A DELEGATE VARIABLE FROM SWIFT Class
        let location = appDelegate.latestLocation
        
        if location == nil {
            return
        }

        for anItem in MyViewState.deals {
            print ("in deal loop")
            var deal: NSString = "";
            if (anItem["deal"] != nil && anItem["latitude"] != nil && anItem["longitude"] != nil)
            {
                 deal = anItem["deal"] as! NSString
            }
            if anItem["deal"] != nil && anItem["latitude"] != nil && anItem["longitude"] != nil && deal != nil && deal.length < 30 {
                print (anItem.keys)
                let dealLatitudeAny = anItem["latitude"] as! String
                let dealLatitude = Double(dealLatitudeAny)

                let dealLongitudeAny = anItem["longitude"] as! String
                let dealLongitude = Double(dealLongitudeAny)
                
                if (dealLatitudeAny != "" && dealLongitudeAny != "")
                {
                    let dealLocation = CLLocation(latitude: dealLatitude! , longitude:  dealLongitude! )
                    let distance = distanceBetween(location1: location!, location2: dealLocation) as Double
             print("distance = %d, %s", distance, deal)
                    if ((distance < Double(MyViewState.dealAlertDistance)) && (hasher[(deal as String) + "setLastSpoke"] == false || hasher[(deal as String) + "setLastSpoke"] == nil)) { // 200
                        //if (anItem["playOnFrontSide"] != nil) {
                        
                        print("SPEAKING " + (anItem["deal"] as! String))
                        if (deal.length < Int(MyViewState.maxDealLength)) {
                            self.speakWords(words: anItem["deal"] as! String);
                        }
                        //}
                        hasher[(deal as String) + "setLastSpoke"] = true;
                    }
                    if (distance > Double(MyViewState.dealAlertDistance) && hasher[(deal as String) + "setLastSpoke"] == true) { //200
                        //if (anItem["playOnBackSide"] != nil) {
                        print("SPEAKING " + (anItem["deal"] as! String))
                        if (deal.length < Int(MyViewState.maxDealLength)) {
                            self.speakWords(words: anItem["deal"] as! String);
                        }
                       // }
                        hasher[(deal as String)+"setLastSpoke"] = false;

                    }
                }
                
            }
        }
    }
    public func distanceBetween(location1: CLLocation, location2: CLLocation) -> Double
    {
        return location1.distance(from: location2)
    }
    class public func processUsers(json: [Dictionary<String, Any>]) -> Void
    {
        //let appDelegate = UIApplication.shared.delegate as! AppDelegate // THIS IS HOW YOU CALL A DELEGATE VARIABLE FROM SWIFT Class
        //appDelegate.deals = json
        users = json
        MyViewState.users = json
        
        for anItem in json as! [Dictionary<String, Any>]  {  // or [[String:Any]]
            if anItem["username"] != nil && anItem["latitude"] != nil && anItem["longitude"] != nil {
                
                let latitude = anItem["latitude"] as! String
                let longitude = anItem["longitude"] as! String
                let userName = anItem["username"] as! String
                print (longitude)
                print (userName)
                print (latitude)
            }
        }
    
    }
    class public func processDeals(json: [Dictionary<String, Any>]) -> Void
    {
        //let appDelegate = UIApplication.shared.delegate as! AppDelegate // THIS IS HOW YOU CALL A DELEGATE VARIABLE FROM SWIFT Class
        //appDelegate.deals = json
        deals = json
        MyViewState.deals = json
        
        for anItem in json as! [Dictionary<String, Any>]  {  // or [[String:Any]]
            if anItem["deal"] != nil && anItem["latitude"] != nil && anItem["longitude"] != nil && anItem["company_name"] != nil{
                let deal = anItem["deal"] as! String
                let latitude = anItem["latitude"] as! String
                let longitude = anItem["longitude"] as! String
                var companyName = anItem["company_name"] as! String
                print (longitude)
                print (deal)
                print (latitude)
                companyName = companyName.replacingOccurrences(of: "'", with: "") // for names like McDonald's
                MyViewState.couponCompanies[companyName] = true
            }
        }
    }
    
    public func makeGetCall(urlInput: String, callBackXX: @escaping ([String: AnyObject]) -> Void) {
        // Set up the URL request
        let endpoint: String = urlInput
        guard let url = URL(string: endpoint) else {
            print("Error: cannot create URL")
            return
        }
        let urlRequest = URLRequest(url: url)
        
        // set up the session
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)

        // make the request
        let task = session.dataTask(with: urlRequest) {
            (data, response, error) in
            // check for any errors
            guard error == nil else {
                print("error calling GET on " + urlInput)
                print(error)
                return
            }
            // make sure we got data
            guard let responseData = data else {
                print("Error: did not receive data")
                return
            }
            // parse the result as JSON, since that's what the API provides
            do {
                guard let todo = try JSONSerialization.jsonObject(with: responseData, options: []) as? [String: AnyObject] else {
                    print("error trying to convert data to JSON")
                    return
                }
                
                callBackXX(todo)
            } catch  {
                print("error trying to convert data to JSON")
                return
            }
            
        }
        
        task.resume()
    }
    
    public func makeGetCallArray(urlInput: String, callBackXX: @escaping ([Dictionary<String,Any>]) -> Void) {
        // Set up the URL request
        let todoEndpoint: String = urlInput
        guard let url = URL(string: todoEndpoint) else {
            print("Error: cannot create URL")
            return
        }
        let urlRequest = URLRequest(url: url)
        
        // set up the session
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
                
        // make the request
        let task = session.dataTask(with: urlRequest) {
            (data, response, error) in
            // check for any errors
            guard error == nil else {
                print("error calling GET on " + urlInput)
                print(error)
                return
            }
            // make sure we got data
            guard let responseData = data else {
                print("Error: did not receive data")
                return
            }
            // parse the result as JSON, since that's what the API provides
            do {
                guard let todo = try JSONSerialization.jsonObject(with: responseData, options: []) as?  [Dictionary<String,AnyObject>] else {
                    print("error trying to convert data to JSON")
                    return
                }
                callBackXX(todo)
            } catch  {
                print("error trying to convert data to JSON")
                return
            }
            
        }
        
        task.resume()
    }

    public func makePostCall(urlInput: String, json: String, callBackXX: @escaping ([String: Any]) -> Void)
    {

        guard let URL = URL(string: urlInput) else {
            print("Error: cannot create URL")
            return
        }
        var UrlRequest = URLRequest(url: URL)
        UrlRequest.httpMethod = "POST"
        UrlRequest.setValue("application/json", forHTTPHeaderField: "Content-type")
        UrlRequest.setValue("application/json", forHTTPHeaderField: "Accept")

        //let newTodo: [String: Any] = ["title": "My First todo", "completed": false, "userId": 1]
        let jsonSerialized: Data
        do {
            if let dataFromString = json.data(using: .utf8, allowLossyConversion: false) {
                //let jsonData = try JSON(data: dataFromString)
                //print(jsonData)
                //jsonSerialized = try JSONSerialization.data(withJSONObject: jsonData, options: [])
                UrlRequest.httpBody = dataFromString
            }

        } catch {
            print("Error: cannot create Serialized JSON from json")
            return
        }
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: UrlRequest) {
            (data, response, error) in
            guard error == nil else {
                print("error calling POST on /todos/1")
                print(error)
                return
            }
            print("RESPONSE=")
            print(response)
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(String(describing: response))")
            }
            
            let responseString = String(data: data!, encoding: .utf8)
            print("responseString = \(String(describing: responseString))")
            guard let responseData = data else {
               
                
                print("Error: did not receive data")
                return
            }
            print("DATA = ")
            
            
            // parse the result as JSON, since that's what the API provides
            do {
                guard let receivedTodo = try JSONSerialization.jsonObject(with: responseData,
                                                                          options:[] ) as? [String: Any] else {
                                                                            print("Could not get JSON from responseData as dictionary")
                                                                            return
                }
                //let array = receivedTodo["responses"] as! [AnyObject?]
                //print (array)
                print (receivedTodo.keys)
                print ("END")
                //self.printArray(values: array)
                var resultHash: [String: String] = [:]
                resultHash["result"] = responseString
                callBackXX(resultHash)
                
            } catch  {
                print("error parsing response from POST on /todos")
                return
            }
        }
        task.resume()
    }
    func printArray(values:[Any?]) {
        for i in 0..<values.count {
            print("value[\(i)] = \(values[i]!)")
        }
    }
    
    /*
     *  Usage
     */
    
    
    

    

    public func jsonParse()
    {
    
    let data = "[{\"form_id\":3465,\"canonical_name\":\"df_SAWERQ\",\"form_name\":\"Activity 4 with Images\",\"form_desc\":null}]".data(using: .utf8)!
    
    struct Form: Codable {
        let id: Int
        let name: String
        let description: String?
        
        private enum CodingKeys: String, CodingKey {
            case id = "form_id"
            case name = "form_name"
            case description = "form_desc"
        }
    }
    
    do {
        let f = try JSONDecoder().decode([Form].self, from: data)
        print(f)
        print(f[0])
    } catch {
        print(error)
    }
    }
    

    
    func  parseOutReceipt(value: String) -> Receipt {
        var company_name = "";
        var website = ""
        var num_days = ""
        var dateString = ""
        var dateVar = Date()
        var promo_code = ""
        var valid_days = "30"
        
        if let regex = try? NSRegularExpression(pattern: "((ftp|http|https):\\/\\/)?(www.)?(?!.*(ftp|http|https|www.))[a-zA-Z0-9_-]+(\\.[a-zA-Z]+)+((\\/)[\\w#]+)*(\\/\\w+\\?[a-zA-Z0-9_]+=\\w+(&[a-zA-Z0-9_]+=\\w+)*)?", options: .caseInsensitive) {
     
            var strArray = regex.matches(in: value, options: [], range: NSRange(location: 0, length: value.lengthOfBytes(using: .ascii)))
            print (strArray.map{
                String(value[Range($0.range, in: value)!])
                }.first
                )
            if (strArray.map{
                String(value[Range($0.range, in: value)!])
                }.count > 0) {
                website = strArray.map{
                    String(value[Range($0.range, in: value)!])
                    }.first!;
            }
            
        }
      

    
    //Log.d("debugme", "Found Code = " + m.group(0));
    if (website.uppercased().contains("POPE") ) {
        website = "www.tellpopeyes.com";
        company_name = "Popeyes";
    }
    if (website.uppercased().contains("DUNKIN") || website.uppercased().contains("DUNK") )
    {
        company_name = "Dunkin Donuts";
        website = "www.telldunkinbaskin.com";
    }
        
    if (website.uppercased().contains("GIANT"))
    {
        company_name = "Giant Foods";
        website = "https://www.talktogiantfoods.com";
    
    }
    
    
    if let regex = try? NSRegularExpression(pattern: "(\\d+[- ])+\\d+", options: .caseInsensitive)
    {
        
        var strArray = regex.matches(in: value, options: [], range: NSRange(location: 0, length: value.lengthOfBytes(using: .ascii)))
        print (strArray.map{
            String(value[Range($0.range, in: value)!])
            }
        )
        print(strArray)

        if (strArray.map{
            String(value[Range($0.range, in: value)!])
            }.count > 0) {
        promo_code = strArray.map{
            String(value[Range($0.range, in: value)!])
            }.first!;
        }

    }
        
    
    if let regex = try? NSRegularExpression(pattern: "(0[1-9]|1[012])[- /.](0[1-9]|[12][0-9]|3[01])[- /.](19|20)\\d\\d", options: .caseInsensitive)
    {
        
        var strArray = regex.matches(in: value, options: [], range: NSRange(location: 0, length: value.lengthOfBytes(using: .ascii)))
        print (strArray.map{
            String(value[Range($0.range, in: value)!])
            }
        )
        print(strArray)
        //json.put("date", m.group(0).replace("///",""));
        if (strArray.map{
            String(value[Range($0.range, in: value)!])
            }.count > 0) {
        dateString = strArray.map{
            String(value[Range($0.range, in: value)!])
            }.first!;
            dateVar = dateFormatter(value: dateString)
        }

    }
         
        if let regex = try? NSRegularExpression(pattern: "within (\\d) days", options: .caseInsensitive)
        {
            var strArray = regex.matches(in: value, options: [], range: NSRange(location: 0, length: value.lengthOfBytes(using: .ascii)))
            print (strArray.map{
                String(value[Range($0.range, in: value)!])
                }
            )
            print (strArray)
            if (strArray.map{
                String(value[Range($0.range, in: value)!])
                }.count > 0) {
            num_days = strArray.map{
                String(value[Range($0.range, in: value)!])
                }.first!;
                num_days = num_days.uppercased().replacingOccurrences(of: "WITHIN", with: "").replacingOccurrences(of: "DAYS", with: "").replacingOccurrences(of: " ", with: "")
print(num_days)
         
            }
        }
 
   
    
    if let regex = try? NSRegularExpression(pattern: "(next|NEXT) (\\d) (days|DAYS)", options: .caseInsensitive)
    {
    
        var strArray = regex.matches(in: value, options: [], range: NSRange(location: 0, length: value.lengthOfBytes(using: .ascii)))
        print (strArray.map{
            String(value[Range($0.range, in: value)!])
            }
        )
        print (strArray)
        //num_days
        if (strArray.map{
            String(value[Range($0.range, in: value)!])
            }.count > 0) {
            valid_days = strArray.map{
                String(value[Range($0.range, in: value)!])
                }.first!;
            valid_days = valid_days.uppercased().replacingOccurrences(of: "NEXT", with: "").replacingOccurrences(of: "DAYS", with: "").replacingOccurrences(of: " ", with: "")

        print(valid_days)
        }
    }
        
    if (value.uppercased().contains("GIANT")) {
        company_name = "Giant Foods";
        website = "http://www.talktogiantfoods.com";
    }
    if (value.uppercased().contains("POPEYE")) {
        company_name = "Popeyes";
        website = "http://www.tellpopeyes.com";
    }
    if (value.uppercased().contains("MCD")) {
        company_name = "McDonalds";
    }
    if (value.uppercased().contains("WHOPPER") || value.uppercased().contains("mybk"))
    {
        company_name = "Burger King";
        website = "http://www.mybkexperience.com";
    }
        
        var receipt = Receipt.init(description: value, company_name: company_name, url: website, promo_code: promo_code,  date: dateVar, num_days: Int(num_days)!, valid_days: Int(valid_days)!)

    //Log.d("debugme", "JSON = " + json.toString());
        return receipt;
    }
    
    func dateFormatter(value: String) -> Date
    {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "MM/dd/yyyy"
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "yyyy-MM-dd"
        
        
        if let date = dateFormatterGet.date(from: value) {
            return date //dateFormatterPrint.string(from: date)
        }
        else
        {
            return Date()
        }
    
    }
    func couponActive(date: String, days: String) -> Bool
    {
        let now = Date()
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd"
        let couponDate = dateFormatterGet.date(from: date)
        
        let futureDate = couponDate?.addingTimeInterval(Double(days)! * 24 * 60 * 60)
        
        if (futureDate! > now) {
            return true
        }
        return false
    }
}
