//
//  WebServiceCallsManager.swift
//  ProficiencyExecercise-Wipro
//
//  Created by Ketaki Mahaveer Kurade on 11/10/20.
//

import Foundation
import Alamofire


class WebServiceCallsManager {
    static let shared = WebServiceCallsManager()
    private init(){}
    
    internal func getData(fromWebService urlString : String, withParameters parameters : [String: Any]? = nil, completionHandler: @escaping ([AboutCanada]?) -> Void) {
        AF.request(urlString, method: .get, parameters: parameters, encoding: URLEncoding.queryString).responseDecodable(of: AllAboutCanada.self) { response in
            guard let allAboutCanada = response.value else {
                return
            }
            let aboutCanada = allAboutCanada.all
            completionHandler(aboutCanada)
        }
    }

    func getImage(fromUrl urlString : String, completionHandler: @escaping (Data) -> Void)  {
        AF.request(urlString, method: .get).responseData(completionHandler: { response in
            switch response.result {
            case .success(let imageData):
                completionHandler(imageData)
                break
                
            case .failure(let failureError):
                print("Error in getting image data : \(failureError.localizedDescription)")
                break
            }
        })
    }
}
