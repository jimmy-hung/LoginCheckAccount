//
//  Data.swift
//  LoginCheckAccount
//
//  Created by 洪立德 on 2019/4/30.
//  Copyright © 2019 洪立德. All rights reserved.
//
/*
 先宣告api裡資料的變數名稱
 撰寫個別的codingkeys與之對應的變數
 若資料有多層級，亦需要逐層拆解分析 - 使用 enum 做分層處理
 若是api資料格式不符合常使用之駝峰式命名，可在 enum codingkeys 裡的 case 另行轉換相與之相符
 
 extension 編寫相對應的解碼處理先拆封外層，再往巢狀內層處理
 */


import Foundation

struct Person: Codable {
    
    var id : Int
    var name : String
    var userName: String
    var email : String
    var phone : String
    var webSite : String
    
    var street : String
    var suite : String
    var city : String
    var zipcode : String
    
    var lat : String
    var lng : String
    
    var companyName : String
    var catchPhrase : String
    var bc : String
    
    // 1
    enum CodingKeys : String, CodingKey {
        
        case id
        case name
        case userName = "username"
        case email
        case phone
        case website
        case address
        case company
        
    }
    
    // 1-1
    enum AddressKeys : String, CodingKey {
        
        case street
        case suite
        case city
        case zipcode
        case geo
    }
    
    // 1-1-1
    enum GeoKeys : String, CodingKey {
        
        case lat
        case lng
    }
    
    // 1-2
    enum Company : String, CodingKey {
        
        case companyName = "name"
        case catchPhrase
        case bc = "bs"
    }
}

extension Person {

    init(from decoder : Decoder) throws {

        // 1
        let deVar = try decoder.container(keyedBy: CodingKeys.self)
        id = try deVar.decode(Int.self, forKey: CodingKeys.id )
        name = try deVar.decode(String.self, forKey: CodingKeys.name)
        userName = try deVar.decode(String.self, forKey: CodingKeys.userName)
        phone = try deVar.decode(String.self, forKey: CodingKeys.phone)
        webSite = try deVar.decode(String.self, forKey: CodingKeys.website)
        email = try deVar.decode(String.self, forKey: CodingKeys.email)
        
        // 1-1
        let address = try deVar.nestedContainer(keyedBy: AddressKeys.self, forKey: .address)
        street = try address.decode(String.self, forKey: AddressKeys.street)
        suite = try address.decode(String.self, forKey: AddressKeys.suite)
        city = try address.decode(String.self , forKey: AddressKeys.city)
        zipcode = try address.decode(String.self, forKey: AddressKeys.zipcode)
        
        // 1-1-1
        let geo = try address.nestedContainer(keyedBy: GeoKeys.self, forKey: .geo)
        lat = try geo.decode(String.self, forKey: GeoKeys.lat)
        lng = try geo.decode(String.self, forKey: GeoKeys.lng)
        
        // 1-2
        let company = try deVar.nestedContainer(keyedBy: Company.self, forKey: .company)
        companyName = try company.decode(String.self, forKey: Company.companyName)
        catchPhrase = try company.decode(String.self, forKey: Company.catchPhrase)
        bc = try company.decode(String.self, forKey: Company.bc)
    }
    
    func encode(to encoder: Encoder) throws {
        var enVar = encoder.container(keyedBy: CodingKeys.self)
        try enVar.encode(id, forKey: .id)
        try enVar.encode(name, forKey: .name)
        try enVar.encode(userName, forKey: .userName)
        try enVar.encode(email, forKey: .email)
        try enVar.encode(phone, forKey: .phone)
        try enVar.encode(webSite, forKey: .website)
        
        var address = enVar.nestedContainer(keyedBy: AddressKeys.self, forKey: .address)
        try address.encode(street, forKey: .street)
        try address.encode(suite, forKey: .suite)
        try address.encode(city, forKey: .city)
        try address.encode(zipcode, forKey: .zipcode)
        
        var geo = address.nestedContainer(keyedBy: GeoKeys.self, forKey: .geo)
        try geo.encode(lat, forKey: .lat)
        try geo.encode(lng, forKey: .lng)
        
        var company = enVar.nestedContainer(keyedBy: Company.self, forKey: .company)
        try company.encode(companyName, forKey: .companyName)
        try company.encode(catchPhrase, forKey: .catchPhrase)
        try company.encode(bc, forKey: .bc)
    }
}

