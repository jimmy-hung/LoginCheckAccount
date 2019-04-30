//
//  Moya.swift
//  LoginCheckAccount
//
//  Created by 洪立德 on 2019/4/25.
//  Copyright © 2019 洪立德. All rights reserved.
//

import Foundation
import Moya


enum UseService {
    
    case searchData
    
}


extension UseService: TargetType {
    
    // "https://data.taipei/opendata/datalist/apiAccess?scope=datasetMetadataSearch&q=id:"
    var baseURL: URL {
        return URL(string: "https://jsonplaceholder.typicode.com")!
    }
    
    // "96f143fe-4c95-4d88-9985-77f28e2d2c3d"
    var path: String {
        switch self {
        case .searchData:
            return "/users"
        }
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var sampleData: Data {
        return "".data(using: .utf8)!
    }
    
    var task: Task {
        switch self {
        case .searchData:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        return nil
    }
}

