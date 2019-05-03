//
//  ViewController.swift
//  LoginCheckAccount
//
//  Created by 洪立德 on 2019/4/24.
//  Copyright © 2019 洪立德. All rights reserved.
//

import UIKit
import Moya

class ViewController: UIViewController {
    
    @IBOutlet weak var accountTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
   
    @IBOutlet weak var checkMailFormatLB: UILabel!
    @IBOutlet weak var checkPasswordLB: UILabel!
    
    @IBOutlet weak var goBtn: UIButton!
    
    var viewModel = ViewModel()
    let user = userData()
    
     // 但斷按鈕是否可用
    var goBtnCanUse = false {
        didSet{
            if goBtnCanUse {
                goBtn.isEnabled = true
                goBtn.alpha = 1
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        viewModel.output = self
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(useTapGesture))
        view.addGestureRecognizer(tapGesture)
        
        checkMailFormatLB.isHidden = true
        checkPasswordLB.isHidden = true
        
        accountTxt.delegate = self
        accountTxt.clearButtonMode = .whileEditing
        accountTxt.addTarget(self, action: #selector(toMointor), for: .allEvents)
        
        passwordTxt.delegate = self
        passwordTxt.clearButtonMode = .whileEditing
        passwordTxt.addTarget(self, action: #selector(toMointor), for: .allEvents)
        
        let notiName = Notification.Name("GOBtn")
        
        NotificationCenter.default.addObserver(self, selector: #selector(getNoti(noti:)), name: notiName, object: nil)
        goBtn.isEnabled = false ; goBtn.alpha = 0.6
        
        accountTxt.text = "123456@gmail.com"
        passwordTxt.text = "12345678"
        
        Singleton.shared.trySingleton()
    }

    @objc func getNoti(noti:Notification){
        
        goBtnCanUse = noti.userInfo!["btn"] as! Bool
        
    }

    @objc func useTapGesture() {
        view.endEditing(true)
    }
    
    @objc func toMointor() {
    
        viewModel.set(userName: accountTxt.text!, password: passwordTxt.text!)
        
    }
    
    @IBAction func goBtn(_ sender: UIButton) {
        
        let nextVC = storyboard?.instantiateViewController(withIdentifier: "second") as! UIViewController
        self.present(nextVC, animated: true, completion: nil)
    }
}

extension ViewController: OutputDelegate {
    func handleUserNameError(_ error: String, final: Bool) {
        
        if !final{
            checkMailFormatLB.text = error
            checkMailFormatLB.isHidden = false
        }else{
            checkMailFormatLB.text = error
            checkMailFormatLB.isHidden = true
        }
        
    }
    
    func handlePasswordError(_ error: String, final: Bool) {
       
        if !final{
            checkPasswordLB.text = error
            checkPasswordLB.isHidden = false
        }else{
            checkPasswordLB.text = error
            checkPasswordLB.isHidden = true
        }
    }
}
