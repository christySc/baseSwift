//
//  ViewController.swift
//  FreeWeddingApp
//
//  Created by 盛超 on 2017/5/27.
//  Copyright © 2017年 sc. All rights reserved.
//

import UIKit
import Kingfisher

class ViewController: UIViewController ,FWBaseRequest , FWBottomDialogueDelegate {
    var b = false
    var bt : UIButton!
   // var requestModelType: String = FWRequestModel.DefaultModel
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        bt = UIButton.init(frame: CGRect.init(x: 100, y: 50, width: 150, height:50))
        bt.setTitleColor(.white, for: .normal)
        bt.setTitle("点我", for: .normal)
        self.view.addSubview(bt)
        bt.backgroundColor = UIColor(red: 1.6, green: 0.4, blue: 0.2, alpha: 1)
        bt.addTarget(self, action: #selector(go), for: .touchUpInside)

       // doSth()
        
    }
    
    func go() {
//        let sheet = FWBottomDialogueView.init(frame: CGRect(x: 0, y: UIScreen.main.bounds.size.height * 0.7, width: kScreenWidthSW, height: kScreenHeightSW * 0.3))
//        sheet.leftBtColor = .red
//        sheet.delegate = self
//        self.view.addSubview(sheet)
//        self.view.FW_makeToast(message: "秀恩爱", image: UIImage(named: "testToast.jpg")!)
        if b == false {
           self.view.showLoading()
            b = true
        }else {
            self.view.hiddenLoading()
            b = false
        }
        
    }
    func doSth() {
        requestData(.GET,apiClient: .ApiHttpMWebURL, URLString: "MiYue", parameters: ["test":"dxl"],success: { (response) in
            print(response!)
        }) { (err) in
            print(err)
        }
        
        
    }
    
    func gainPicker(string : String) {
        bt.setTitle(string, for: .normal)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

