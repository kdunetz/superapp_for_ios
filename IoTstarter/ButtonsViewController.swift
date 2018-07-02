//
//  ButtonsViewController.swift
//  IoTstarter
//
//  Created by Kevin Dunetz on 6/7/18.
//  Copyright © 2018 Mike Robertson. All rights reserved.
//

import UIKit

class ButtonsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func playDeals(_ sender: Any) {
        let paf = PlayAroundFile()
        paf.playDeals()
    }
    
    @IBAction func findSimilarPeople(_ sender: Any) {
  
        let paf = PlayAroundFile()
        paf.makeGetCallArray(urlInput: "https://new-node-red-demo-kad.mybluemix.net/getAll?object_name=object_one", callBackXX: ButtonsViewController.findSimilarPeopleCallback)
    }
    
    class public func findSimilarPeopleCallback(json: [Dictionary<String, Any>]) -> Void

    {
        let appUser: [String: AnyObject] = ["username": "Kevin" as AnyObject, "search_key_words": "skiing" as AnyObject]
        for anItem in json as! [Dictionary<String, Any>]  {
            if anItem["username"] != nil, anItem["search_key_words"] != nil {
                let userName = anItem["username"] as! String
            
                let searchKeyWords = anItem["search_key_words"] as! String
                print (userName + searchKeyWords)
                let appUserSearchKeyWords = appUser["search_key_words"] as! String
                if (appUser["username"] as! String != userName && strlen(searchKeyWords) > 0 && (appUserSearchKeyWords.contains(searchKeyWords)))
                {
                    print ("Found a match")
                }
                

            }
        }
        print("in findSimilarPeopleCallback")
    }
    @IBAction func ShowSettings(_ sender: Any) {
        let storyboard: UIStoryboard = UIStoryboard(name: "Second_iPhone", bundle: nil)
        let vc: UIViewController = storyboard.instantiateViewController(withIdentifier: "settingsID") as UIViewController
        self.present(vc, animated: true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func showCamera(_ sender: Any) {
        let storyboard: UIStoryboard = UIStoryboard(name: "Second_iPhone", bundle: nil)
        let vc: UIViewController = storyboard.instantiateViewController(withIdentifier: "cameraID") as UIViewController
        self.present(vc, animated: true, completion: nil)
        
        //var imagePicker: UIImagePickerController!
        //imagePicker =  UIImagePickerController()
        //let storyboard: UIStoryboard = UIStoryboard(name: "Second_iPhone", bundle: nil)
        //let vc: UIViewController = storyboard.instantiateViewController(withIdentifier: "cameraID") as UIViewController
        //imagePicker.delegate = TakePictureViewController //UIImagePickerController
        //imagePicker.sourceType = .camera
        //present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func showDynamicTable(_ sender: Any) {
        let storyboard: UIStoryboard = UIStoryboard(name: "Main_iPhone", bundle: nil)
        let vc: UIViewController = storyboard.instantiateViewController(withIdentifier: "dynamicTable") as UIViewController
        self.present(vc, animated: true, completion: nil)
    }
    @IBAction func showQRReader(_ sender: Any) {
        let storyboard: UIStoryboard = UIStoryboard(name: "Main_iPhone", bundle: nil)
        let vc: UIViewController = storyboard.instantiateViewController(withIdentifier: "qrReader") as UIViewController
        self.present(vc, animated: true, completion: nil)
    }
}
