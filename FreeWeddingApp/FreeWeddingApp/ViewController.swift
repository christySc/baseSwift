//
//  ViewController.swift
//  FreeWeddingApp
//
//  Created by 盛超 on 2017/5/27.
//  Copyright © 2017年 sc. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
var mytable = UITableView()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .Red_FE   
        // Do any additional setup after loading the view, typically from a nib.
        self.addtableview()
    }
    
    func addtableview(){
//        mytable.delegate = self
//        mytable.dataSource = self
        mytable.snp.makeConstraints { (make) in
            make.edges.equalTo(self.view)
        }
        self.view.addSubview(mytable)
    }
    
//    func tab
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

