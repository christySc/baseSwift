//
//  ViewController.swift
//  FreeWeddingApp
//
//  Created by 盛超 on 2017/5/27.
//  Copyright © 2017年 sc. All rights reserved.
//

import UIKit
import Kingfisher

class ViewController: UIViewController ,FWBaseRequest {
    
    var requestModelType: FWRequestModel = .DefaultModel
    override func viewDidLoad() {
        super.viewDidLoad()
        doSth()
        
    }
    func doSth() {
        requestData(.GET,apiClient: .ApiHttpMWebURL, URLString: "MiYue", parameters: ["test":"dxl"],success: { (response) in
            print(response!)
        }) { (err) in
            print(err)
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

