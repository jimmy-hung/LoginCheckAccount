//
//  extension+string.swift
//  LoginCheckAccount
//
//  Created by 洪立德 on 2019/4/24.
//  Copyright © 2019 洪立德. All rights reserved.
//

import Foundation

extension String {
    
    // 判斷有無注音
    func isContainsPhoneticCharacters() -> Bool {
        for scalar in self.unicodeScalars {
            if (scalar.value >= 12549 && scalar.value <= 12582) || (scalar.value == 12584 || scalar.value == 12585 || scalar.value == 19968) {
                return true
            }
        }
        return false
    }
    
    // 判斷有無中文
    func isContainsChineseCharacters() -> Bool {
        for scalar in self.unicodeScalars {
            if scalar.value >= 19968 && scalar.value <= 171941 {
                return true
            }
        }
        return false
    }
    
    // 是否含有空白字元
    func isContainsSpaceCharacters() -> Bool {
        for scalar in self.unicodeScalars {
            if scalar.value == 32 {
                return true
            }
        }
        return false
    }
    
}
