//
//  TakeAPictureViewController.swift
//  IoTstarter
//
//  Created by Kevin Dunetz on 6/8/18.
//  Copyright © 2018 Mike Robertson. All rights reserved.
//

import UIKit
extension UIImage {
    
    func resizeByByte(maxByte: Int) {
        
        var compressQuality: CGFloat = 1
        var imageByte = UIImageJPEGRepresentation(self, 1)?.count
        
        while imageByte! > maxByte {
            
            imageByte = UIImageJPEGRepresentation(self, compressQuality)?.count
            compressQuality -= 0.1
        }
    }
}

extension UIImage
{
    var highestQualityJPEGNSData: NSData { return UIImageJPEGRepresentation(self, 1.0)! as NSData }
    var highQualityJPEGNSData: NSData    { return UIImageJPEGRepresentation(self, 0.75)! as NSData}
    var mediumQualityJPEGNSData: NSData  { return UIImageJPEGRepresentation(self, 0.5)! as NSData }
    var lowQualityJPEGNSData: NSData     { return UIImageJPEGRepresentation(self, 0.25)! as NSData}
    var lowestQualityJPEGNSData: NSData  { return UIImageJPEGRepresentation(self, 0.0)! as NSData }
}

class TakePictureViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    var imagePicker: UIImagePickerController!

    @IBAction func takeAPicture(_ sender: Any) {
        imagePicker =  UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .camera
        present(imagePicker, animated: true, completion: nil)
    }
    @IBOutlet var pictureView: UIImageView!
    
    @IBAction func saveDealToDatabase(_ sender: Any) {
    }
    
    @IBOutlet var dealTextField: UITextField!
    @IBOutlet var dateTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker =  UIImagePickerController()
        //imagePicker.delegate = TakePictureViewController
        imagePicker.sourceType = .camera
        present(imagePicker, animated: true, completion: nil)
        dealTextField.isHidden = true
        dateTextField.isHidden = true

        // Do any additional setup after loading the view.
    }


        
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        imagePicker.dismiss(animated: true, completion: nil)
        pictureView.image = info["UIImagePickerControllerOriginalImage"] as? UIImage
        
        let imageData = pictureView.image?.lowestQualityJPEGNSData
        
        //let imageData:NSData = UIImagePNGRepresentation(image)! as NSData
        let strBase64 = imageData?.base64EncodedString(options: .lineLength64Characters)
        //let strBase64 = "R0lGODlhAQABAIAAAAUEBAAAACwAAAAAAQABAAACAkQBADs="
        //print(strBase64)
        let paf = PlayAroundFile()
        
        /*
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
        struct Foo: Codable {
            // MARK: - Properties
            let bar: Bool
            let baz: String
            let bestFriend: String
            let funnyGuy: String
            let favoriteWeirdo: String
            // MARK: - Codable
            // Coding Keys
            enum CodingKeys: String, CodingKey {
                case response = "Response"
                case bar = "Bar"
                case baz = "Baz"
                case friends = "Friends"
                case bestFriend = "Best"
                case funnyGuy = "FunnyGuy"
                case favoriteWeirdo = "FavoriteWeirdo"
            }
            // Decoding
            init(from decoder: Decoder) throws {
                let container = try decoder.container(keyedBy: CodingKeys.self)
                let response = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .response)
                bar = try response.decode(Bool.self, forKey: .bar)
                baz = try response.decode(String.self, forKey: .baz)
                let friends = try response.nestedContainer(keyedBy: CodingKeys.self, forKey: .friends)
                bestFriend = try friends.decode(String.self, forKey: .bestFriend)
                funnyGuy = try friends.decode(String.self, forKey: .funnyGuy)
                favoriteWeirdo = try friends.decode(String.self, forKey: .favoriteWeirdo)
            }
            // Encoding
            func encode(to encoder: Encoder) throws {
                var container = encoder.container(keyedBy: CodingKeys.self)
                var response = container.nestedContainer(keyedBy: CodingKeys.self, forKey: .response)
                try response.encode(bar, forKey: .bar)
                try response.encode(baz, forKey: .baz)
                var friends = response.nestedContainer(keyedBy: CodingKeys.self, forKey: .friends)
                try friends.encode(bestFriend, forKey: .bestFriend)
                try friends.encode(funnyGuy, forKey: .funnyGuy)
                try friends.encode(favoriteWeirdo, forKey: .favoriteWeirdo)
            }
        }
        let myFoo = try! JSONDecoder().decode(Foo.self, from: data)
        // Initializes a Foo object from the JSON data at the top.
        let dataToSend = try! JSONEncoder().encode(myFoo)
        // Turns your Foo object into raw JSON data you can send back!

        
        do {
            let f = try JSONDecoder().decode([Form].self, from: data)
            print(f)
            print(f[0])
        } catch {
            print(error)
        }
 */
        var json = "{\n"
        json += "\"requests\": [\n"
        json += "    {\n"
        json += "      \"image\": {\n"
        json += "        \"content\": \"" + strBase64! + "\"\n"
        json += "},\n"
        json += "      \"features\": [\n"
        json += "        {\n"
        json += "          \"type\": \"TEXT_DETECTION\"\n"
        json += "        }\n"
        json += "      ]\n"
        json += "    }\n"
        json += "  ]\n"
        json += "}";
        print (json)
        paf.makePostCall(urlInput: "https://vision.googleapis.com/v1/images:annotate?key=AIzaSyBESW49t48CGrcITU7-V34PeQkWAoOeBYM", json: json, callBackXX: processImageResult)
        /*
         bitmapImage = BitmapFactory.decodeStream(new ByteArrayInputStream(out.toByteArray()));
         
         Log.d("debugme", "Saved");
         String base64String = Utility.encodeTobase64(bitmapImage);
         String json = "{\n" +
         "  \"requests\": [\n" +
         "    {\n" +
         "      \"image\": {\n" +
         "        \"content\": \"" + base64String + "\"\n" +
         "      },\n" +
         "      \"features\": [\n" +
         "        {\n" +
         "          \"type\": \"TEXT_DETECTION\"\n" +
         "        }\n" +
         "      ]\n" +
         "    }\n" +
         "  ]\n" +
         "}";
         Log.d("debugme", json);
         
         Utility.callRESTAPI(getContext(), "https://vision.googleapis.com/v1/images:annotate?key=AIzaSyBESW49t48CGrcITU7-V34PeQkWAoOeBYM", "post", ACTION_FOR_INTENT_CALLBACK, json);
         
         */
    }
    func processImageResult(json: [String: Any]) -> Void
    {
        print ("In processImageResult")
        print(json["result"])
     
        DispatchQueue.main.async { // 2
            self.dealTextField.isHidden = false
            self.dateTextField.isHidden = false
            self.dealTextField.text = "Kevin"
            self.dateTextField.text = "Bob"
        }
        
        //let appDelegate = UIApplication.shared.delegate as! AppDelegate // THIS IS HOW YOU CALL A DELEGATE VARIABLE FROM SWIFT Class
        //appDelegate.displayViewController("Hello")
        

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
    */

}
