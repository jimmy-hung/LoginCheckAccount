//
//  ShortData.swift
//  LoginCheckAccount
//
//  Created by 洪立德 on 2019/4/30.
//  Copyright © 2019 洪立德. All rights reserved.
//

import Foundation

struct Human: Codable {
    
    var id : Int
    
    var zipcode : String
    
    var lat : String
    
    var bs : String
    
    // 1
    enum CodingKeys : String, CodingKey {
        
        case id
        case name
        case userName
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
        
        case companyName
        case catchPhrase
        case bs
        
    }
    
}

extension Human {
    
    init(from decoder : Decoder) throws {
        
        // 1
        let deVar = try decoder.container(keyedBy: CodingKeys.self)
        id = try deVar.decode(Int.self, forKey: CodingKeys.id )
        
        // 1-1
        let address = try deVar.nestedContainer(keyedBy: AddressKeys.self, forKey: .address)
        zipcode = try address.decode(String.self, forKey: AddressKeys.zipcode)
        
        // 1-1-1
        let geo = try address.nestedContainer(keyedBy: GeoKeys.self, forKey: .geo)
        lat = try geo.decode(String.self, forKey: GeoKeys.lat)
        
        // 1-2
        let company = try deVar.nestedContainer(keyedBy: Company.self, forKey: .company)
        bs = try company.decode(String.self, forKey: Company.bs)
        
        
    }
    
    func encode(to encoder: Encoder) throws {
        var enVar = encoder.container(keyedBy: CodingKeys.self)
        try enVar.encode(id, forKey: .id)
        
        var address = enVar.nestedContainer(keyedBy: AddressKeys.self, forKey: .address)
        try address.encode(zipcode, forKey: .zipcode)
        
        var geo = address.nestedContainer(keyedBy: GeoKeys.self, forKey: .geo)
        try geo.encode(lat, forKey: .lat)
        
        var company = enVar.nestedContainer(keyedBy: Company.self, forKey: .company)
        try company.encode(bs, forKey: .bs)
    }
}
