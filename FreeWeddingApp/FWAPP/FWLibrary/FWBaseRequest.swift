//
//  FWBaseRequest.swift
//  FreeWeddingApp
//
//  Created by 盛超 on 2017/6/1.
//  Copyright © 2017年 sc. All rights reserved.
//

import Foundation
import Alamofire
import HandyJSON

enum MethodType {
    case GET
    case POST
}


#if TEST
    enum DXLApiClientType : String {
        
        case ApiBaseURL     = "http://api.daoxila.com/"
        case ApiMyURL       = "http://my.daoxila.com/"
        case ApiHttpMWebURL = "http://m.daoxila.com/"
        case ApiHttpBURL    = "http://b.daoxila.com/"
        case ApiJsonpURL    = "http://jsonp.daoxila.com/"
    }
#else
    
    enum DXLApiClientType : String {
        
        case ApiHttpMWebURL        =   "http://m.daoxila.com/"
        case ApiMyURL              =   "https://my.daoxila.com/"
        case ApiBaseURL            =   "https://api.daoxila.com/"
        case ApiHttpBURL           =   "https://b.daoxila.com/"
        case ApiJsonpURL           =   "https://jsonp.daoxila.com/"
    }

#endif

enum modelType {
    case defaultModel
}

class FWRequestModel {
    
}

extension FWRequestModel {
    open class var DefaultModel : FWRequestModel {
        return chooseRight(ModelType: .defaultModel) as! FWRequestModel
    }
}

private func chooseRight(ModelType : modelType) -> Any! {
    switch ModelType {
    case .defaultModel: return FWRequestBaseModel()
    }
}
protocol FWBaseRequest {
    
    var requestModelType : FWRequestModel{get}
}

extension FWBaseRequest {
    
    

    ///
    /// - Parameters:
    ///   - type: get/post
    ///   - apiClient:  URL前缀
    ///   - URLString: 参数
    ///   - parameters: param
    ///   - success: 成功回调
    ///   - failture: 失败回调
     func requestData(_ type : MethodType , apiClient : DXLApiClientType = .ApiBaseURL , URLString : String , parameters : [String : Any]? = nil,  success : @escaping (_ response : Any?)->(), failture : @escaping (_ error : Error)->()) {
        let method = type == .GET ? HTTPMethod.get : HTTPMethod.post
        var tmpStr = URLString
        tmpStr = apiClient.rawValue.appending(tmpStr)
        Alamofire.request(tmpStr, method :method,parameters :parameters).responseJSON {(response) in
            guard response.result.value != nil else {
               // FWPrint(message: response.result.error!)
                failture(response.result.error!)
                return
            }
            // 4.将结果回调出去
            success(response.result.value)
            }
        }
    }

struct FWBaseRequestManager : FWBaseRequest {
    var requestModelType : FWRequestModel
}
