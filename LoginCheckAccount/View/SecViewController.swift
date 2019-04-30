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

    @IBOutlet weak var nextPageLb: UILabel!
    
    //MARK: Moya
    var useMoya = MoyaProvider<UseService>()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        moyaTool()
    }
    
    //MARK: Moya
    func moyaTool() {
        
//        var json : NSArray?
        
        useMoya.request(.searchData) { (result) in
            
            switch result{
            case .success(let response):
                
                let decoder = JSONDecoder()
//                let json = try! JSONSerialization.jsonObject(with: response.data, options: [])
//                self.nextPageLb.text = "\(json)"
                
                // 完整
                do {
                    let persons = try decoder.decode([Person].self, from: response.data)
                    
                    for i in 0 ... persons.count - 1 {
                        
                        print(persons[i].id, persons[i].email, persons[i].city)
                        
                    }
                    
                } catch {
                    print(error)
                }
                // 部分
//                do {
//                    let humans = try decoder.decode([Human].self, from: response.data)
//
//                    print(humans)
//
//                } catch {
//                  print(error)
//                }
                
            case .failure(let error):
                self.nextPageLb.text = "\(error)"
                print(error)
            }
        }
    }
    
    @IBAction func dismissBtn(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}
