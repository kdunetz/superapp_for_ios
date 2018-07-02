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
        
        couponAlertDistance.insertText(String(MyViewState.couponAlertDistance))
        dealAlertDistance.insertText(String(MyViewState.dealAlertDistance))
        maxDealLength.insertText(String(MyViewState.maxDealLength))
        localBusinessSearchRadius.insertText(String(MyViewState.localBusinessSearchRadius))
        
        // Do any additional setup after loading the view.
    }
    @IBAction func saveSettings(_ sender: Any) {
        MyViewState.couponAlertDistance = Double(couponAlertDistance.text!)!
        MyViewState.dealAlertDistance = Double(dealAlertDistance.text!)!
        MyViewState.maxDealLength = Double(maxDealLength.text!)!
        MyViewState.localBusinessSearchRadius = Double(localBusinessSearchRadius.text!)!
        self.dismiss(animated: true, completion: nil)
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
