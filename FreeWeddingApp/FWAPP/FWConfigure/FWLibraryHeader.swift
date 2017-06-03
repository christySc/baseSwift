//
//  FWLibraryHeader.swift
//  FreeWeddingApp
//
//  Created by 盛超 on 2017/5/27.
//  Copyright © 2017年 sc. All rights reserved.
//

import UIKit


//屏幕尺寸定义

let kScreenBoundsSW = UIScreen.main.bounds
let kScreenWidthSW = UIScreen.main.bounds.size.width
let kScreenHeightSW = UIScreen.main.bounds.size.height

func kScaleFrom_iPhone6_DesginSW(_: CGFloat) ->(CGFloat) {
    return UIScreen.main.bounds.size.width/375
}

//版本判断

let IOS_VERSION_SW = UIDevice.current.systemVersion
let IOS_VERSION_INTGER_SW = (UIDevice.current.systemVersion as NSString).integerValue
let IOS_VERSION_MORE_THEN_8_SW : Bool = IOS_VERSION_INTGER_SW >= 8
let IOS_VERSION_MORE_THEN_9_SW : Bool = IOS_VERSION_INTGER_SW >= 9
let IOS_VERSION_MORE_THEN_10_SW : Bool = IOS_VERSION_INTGER_SW >= 10

//log

public func FWPrint<T>(_ message : T, file : String = #file, lineNumber : Int = #line) {
    #if DEBUG
        let fileName = (file as NSString).lastPathComponent
        print("\(fileName),line \(lineNumber):  \(message)")
    #endif
}

//测试
#if DEBUG
#endif





class FWLibraryHeader: NSObject {

}
