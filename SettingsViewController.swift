//
//  SettingsViewController.swift
//  IoTstarter
//
//  Created by Kevin Dunetz on 7/1/18.
//  Copyright © 2018 Kevin Dunetz. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    @IBOutlet weak var dealAlertDistance: UITextField!
    @IBOutlet weak var couponAlertDistance: UITextField!
    @IBOutlet weak var maxDealLength: UITextField!
    @IBOutlet weak var localBusinessSearchRadius: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        couponAlertDistance.text = String(MyViewState.couponAlertDistance)
        dealAlertDistance.text = String(MyViewState.dealAlertDistance)
        maxDealLength.text = String(MyViewState.maxDealLength)
        localBusinessSearchRadius.text = String(MyViewState.localBusinessSearchRadius)
        
        // Do any additional setup after loading the view.
    }
    @IBAction func saveSettings(_ sender: Any) {
        MyViewState.couponAlertDistance = Double(couponAlertDistance.text!)!
        MyViewState.dealAlertDistance = Double(dealAlertDistance.text!)!
        MyViewState.maxDealLength = Double(maxDealLength.text!)!
        MyViewState.localBusinessSearchRadius = Double(localBusinessSearchRadius.text!)!
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func resetSettings(_ sender: Any) {
        couponAlertDistance.text = "200"
        dealAlertDistance.text = "200"
        maxDealLength.text = "30"
        localBusinessSearchRadius.text = "400"
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
