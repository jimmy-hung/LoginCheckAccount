//
//  Data2.swift
//  LoginCheckAccount
//
//  Created by 洪立德 on 2019/5/2.
//  Copyright © 2019 洪立德. All rights reserved.
//
/*
 先宣告api裡資料的變數名稱
 若是api資料格式不符合常使用之駝峰式命名，可在 enum codingkeys 裡的 case 另行轉換相與之相符
 
 */

import Foundation

struct SecPerson: Codable {
    
    var id : Int
    var name : String
    var userName: String
    var email : String
    var address : SecPersonAddress
    
    var phone : String
    var webSite : String
    var company : SecPersonCompany
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case userName = "username"
        case email
        case address
        case phone
        case webSite = "website"
        case company
    }
}

struct SecPersonAddress: Codable {
    
    var street : String
    var suite : String
    var city : String
    var zipcode : String
    var geo : AddressGeo
    
}

struct AddressGeo: Codable {
    
    var lat : String
    var lng : String
    
}

struct SecPersonCompany: Codable {
    
    var companyName : String
    var catchPhrase : String
    var bs : String
    
    enum CodingKeys : String, CodingKey {
        
        case companyName = "name"
        case catchPhrase
        case bs
    }
}

