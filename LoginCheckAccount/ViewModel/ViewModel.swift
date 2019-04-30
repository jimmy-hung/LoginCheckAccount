//
//  ViewModel.swift
//  LoginCheckAccount
//
//  Created by 洪立德 on 2019/4/24.
//  Copyright © 2019 洪立德. All rights reserved.
//

import Foundation
import Moya


class ViewModel: NSObject {

    
    var userName: String?
    var password: String?

    var nameFail = ""
    var passwordFail = ""
    
    weak var output: OutputDelegate?
    
    func set(userName: String, password: String) {
        
        let notiName = Notification.Name("GOBtn")

        if checkName(userName: userName) && checkPassword(password: password) {
            NotificationCenter.default.post(name: notiName, object: nil, userInfo: ["btn":true])
        } else {
            NotificationCenter.default.post(name: notiName, object: nil, userInfo: ["btn":false])
        }
    }
    
    func checkName(userName: String) -> Bool{
        
        var nameFinal = false
        if userName != "" {
            if checkUserName(name: userName) {
                self.userName = userName
                nameFinal = true
            } else {
                nameFail = "email format error"
            }
        }else{
            nameFail = ""
        }
        
        output?.handleUserNameError(nameFail, final: nameFinal)
        return nameFinal
    }
    
    func checkPassword(password: String) -> Bool{
        
        var passwordFinal = false
        if password != ""{
            guard password.count > 5 else {
                passwordFail = "more than five"
                output?.handlePasswordError(passwordFail, final: passwordFinal)
                return passwordFinal
            }
            
            guard !password.isContainsChineseCharacters() else {
                passwordFail = "Contains Chinese Characters"
                
                output?.handlePasswordError(passwordFail, final: passwordFinal)
                return passwordFinal
            }
            
            guard !password.isContainsPhoneticCharacters() else {
                passwordFail = "Contains Phonetic Characters"
                
                output?.handlePasswordError(passwordFail, final: passwordFinal)
                return passwordFinal
            }
            
            guard !password.isContainsSpaceCharacters() else {
                passwordFail = "Contains Space Characters"
                
                output?.handlePasswordError(passwordFail, final: passwordFinal)
                return passwordFinal
            }
            
            self.password = password
            passwordFinal = true
            output?.handlePasswordError(passwordFail, final: passwordFinal)
            return passwordFinal
        }else{
            passwordFail = ""
            output?.handlePasswordError(passwordFail, final: passwordFinal)
            return passwordFinal
        }
    }
    
    func checkUserName(name: String) -> Bool{
        let emailRegex = "^\\w+((\\-\\w+)|(\\.\\w+))*@[A-Za-z0-9]+((\\.|\\-)[A-Za-z0-9]+)*.[A-Za-z0-9]+$"
        let emailTest = NSPredicate(format: "SELF MATCHES%@", emailRegex)
        let checkEmailResult:Bool = emailTest.evaluate(with: name)
        
        return checkEmailResult
    }
}

protocol OutputDelegate: class {
    func handleUserNameError(_ text: String, final: Bool)
    func handlePasswordError(_ text: String, final: Bool)
}
