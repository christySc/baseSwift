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

public let FWTEST : Bool = true

#if FWTEST
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

//选择用什么model来接收数据

enum modelType {
    case defaultModel
}


protocol FWBaseRequest {
    
    func requestData(_ type : MethodType , apiClient : DXLApiClientType, URLString : String , parameters : [String : Any]?,responseModelType : modelType,  success : @escaping (_ response : Any?)->(), failture : @escaping (_ error : Error)->())

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
    func requestData(_ type : MethodType , apiClient : DXLApiClientType = .ApiBaseURL , URLString : String , parameters : [String : Any]? = nil,responseModelType : modelType = .defaultModel,  success : @escaping (_ response : Any?)->(), failture : @escaping (_ error : Error)->()) {
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
            if let json = response.result.value {
                
                let strDic = json as? Dictionary<String , Any>
             
                if let model = chooseResponseModel(responseModelType, strDictionary: strDic)
                {
                   success(model)
                }
            }
            
            }
        }
    }
//mark: handyJSON解析
private func chooseResponseModel(_ modelType : modelType , strDictionary : Dictionary<String, Any>?) -> Any? {
    
    guard strDictionary != nil else {return nil}
    switch modelType {
    case .defaultModel:
        return JSONDeserializer<FWRequestBaseModel>.deserializeFrom(dict: (strDictionary! as NSDictionary))
  
    }
}

struct FWBaseRequestManager : FWBaseRequest {

}


