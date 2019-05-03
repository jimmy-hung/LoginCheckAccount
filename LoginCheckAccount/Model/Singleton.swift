//
//  Singleton.swift
//  LoginCheckAccount
//
//  Created by 洪立德 on 2019/5/3.
//  Copyright © 2019 洪立德. All rights reserved.
//

import Foundation

class Singleton: NSObject {
    
    static let shared = Singleton()
    
    var countCalledTime = 0
    
    private override init() {
        print("start init")
    }
    
    deinit {
        print("ready to deinit")
    }
    
    func trySingleton() {
        
        countCalledTime += 1
        
        print("start single: \(countCalledTime)")
    }
    
}
