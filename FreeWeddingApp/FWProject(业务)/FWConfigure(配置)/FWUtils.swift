//
//  FWUtils.ift
//  FreeWeddingApp
//
//  Created by 盛超 on 2017/5/27.
//  Copyright © 2017年 sc. All rights reserved.
//

import UIKit


//颜色

func FWUIGetColor(_ sender:Any)->UIColor {
    
    var color : UIColor = UIColor.black
    if ((sender as AnyObject) .isKind(of: UIColor.self)) {
        color = sender as! UIColor
    }
    else if(sender is String) {
        var cString = (sender as AnyObject).trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines).uppercased()
        if cString.hasPrefix("#") {
            cString = (cString as NSString).substring(from: 1)
        }
        if cString.characters.count != 6 {
            color = UIColor.gray
            return color
        }
        let rString = (cString as NSString).substring(to: 2)
        let gString = ((cString as NSString).substring(from: 2) as NSString).substring(to: 2)
        let bString = ((cString as NSString).substring(from: 4) as NSString).substring(to: 2)
        var r:CUnsignedInt = 0, g:CUnsignedInt = 0, b:CUnsignedInt = 0
        Scanner(string:rString).scanHexInt32(&r)
        Scanner(string:gString).scanHexInt32(&g)
        Scanner(string:bString).scanHexInt32(&b)
        
        color = UIColor.init(red: CGFloat(r)/255.0, green: CGFloat(g)/255.0, blue: CGFloat(b)/255.0, alpha: 1)
    }
    return color
}

//大小

func getFontSW(_ sender :Any)->UIFont {
    if (sender as AnyObject).isKind(of: UIFont.self) {
        return sender as! UIFont
    }
    else if (sender as AnyObject).isKind(of: NSNumber.self) {
        return UIFont.systemFont(ofSize: CGFloat((sender as! NSNumber).floatValue))
    }
    else {
        print("getFont方法传入参数不合法,已把font归0")
        return UIFont.systemFont(ofSize: 0)
    }
}


open class FWUtils: NSObject {
    
}

extension UIColor {
    open class var Red_FE : UIColor {
            return FWUIGetColor("FE608E")
    }
    open class var Red_FF : UIColor {
        return FWUIGetColor("FF6E95")
    }
    open class var Red_618D : UIColor {
        return FWUIGetColor("FF618D")
    }
    open class var Red_608E : UIColor {
        return FWUIGetColor("FF608E")
    }
    open class var Red_FF3366 : UIColor {
        return FWUIGetColor("FF3366")
    }
    open class var Gray_D4 : UIColor {
        return FWUIGetColor("D4D4D4")
    }
    open class var Gray_3 : UIColor {
        return FWUIGetColor("333333")
    }
    open class var Gray_6 : UIColor {
        return FWUIGetColor("666666")
    }
    open class var Gray_9 : UIColor {
        return FWUIGetColor("999999")
    }
}
