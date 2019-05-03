//
//  SecViewController.swift
//  LoginCheckAccount
//
//  Created by 洪立德 on 2019/4/24.
//  Copyright © 2019 洪立德. All rights reserved.
//

import UIKit
import Moya

class SecViewController: UIViewController {

    @IBOutlet weak var allBtn: UIButton!
    @IBOutlet weak var apartBtn: UIButton!
    @IBOutlet weak var secAllBtn: UIButton!
    
    //MARK: Moya
    var useMoya = MoyaProvider<UseService>()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        moyaTool()
        Singleton.shared.trySingleton()
    }
    
    //MARK: Moya
    func moyaTool() {
                
        useMoya.request(.searchData) { (result) in
            
            switch result{
            case .success(let response):
                
                let decoder = JSONDecoder()

                    // 完整
                    do {
                        let persons = try decoder.decode([Person].self, from: response.data)
                        
                        for everyone in persons {
                            
                            print(everyone.id, everyone.email, everyone.city)
                        }
                    } catch {
                        print(error)
                    }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    @IBAction func dismissBtn(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}
