//
//  ViewController.swift
//  FreeWeddingApp
//
//  Created by 盛超 on 2017/5/27.
//  Copyright © 2017年 sc. All rights reserved.
//

import UIKit
import Kingfisher

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .Red_FE
        let test = FWCycleItemView(frame:self.view.bounds)
        test.backgroundColor = .yellow
        test.imgView.kf.setImage(with: URL.init(string: "https://i.dxlfile.com/hotel/large/2017-05/20170519171682933.jpg"), placeholder: UIImage.init(named: "小明.jpeg"), options: nil, progressBlock: nil, completionHandler: nil)
        self.view.addSubview(test)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

