//
//  Utility.swift
//  IoTstarter
//
//  Created by Kevin Dunetz on 6/14/18.
//  Copyright © 2018 Mike Robertson. All rights reserved.
//

import Foundation

struct MyViewState {
    static var deals: [Dictionary<String, Any>] = []
    static var users: [Dictionary<String, Any>] = []
    static var couponCompanies: [String: Bool] = [:]
    static var couponHash: [String: Bool] = [:]
    static var localBusinesses: [Dictionary<String, Any>] = []
    static var currentUser = ""
    static var appUser: [String: String] = [:]
    static var localBusinessSearchRadius = 1000 as Double
    static var dealAlertDistance = 200 as Double
    static var maxDealLength = 30 as Double
    static var couponAlertDistance = 200 as Double
}

struct Receipt {
    let description: String
    let company_name: String
    let url: String
    let promo_code: String
    let date: Date
    let num_days: Int
    let valid_days: Int
}
