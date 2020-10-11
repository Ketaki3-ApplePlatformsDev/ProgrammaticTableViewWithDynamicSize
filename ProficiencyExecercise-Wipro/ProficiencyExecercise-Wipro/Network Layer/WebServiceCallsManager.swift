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
    
    internal func getData(fromWebService urlString : String, withParameters parameters : [String: Any]? = nil, completionHandler: @escaping CompletionHandler) {
        AF.request(urlString, method: .get, parameters: nil, encoding: URLEncoding.queryString).validate().responseJSON(queue: DispatchQueue.global(), options:
            .allowFragments, completionHandler: { response in
                
                if let jsonData = response.data {
                    let jsonString = String(data: jsonData, encoding: String.Encoding.ascii)
                    let data = jsonString!.data(using: String.Encoding.utf8)
                    let allAboutCanada = try? JSONDecoder().decode(AllAboutCanada.self, from: data!)
                    if var aboutCanada = allAboutCanada?.all {
                        guard let title = allAboutCanada?.title else {
                            completionHandler(false, nil, nil)
                            return
                        }
                        // Removing Row if all three values i.e, title, description and imageHref are empty to prevent showing empty cell.
                        var index:Int = 0
                        for row in aboutCanada {
                            let title = row.title
                            let description = row.description
                            let imageURL = row.imageURL
                            if(title == nil && description == nil && imageURL == nil){
                                aboutCanada.remove(at: index)
                            }
                            index = index + 1
                        }
                        completionHandler(true, aboutCanada, title)
                    }
                }
        })
    }
}
