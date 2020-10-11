//
//  NetworkConnectivityManager.swift
//  ProficiencyExecercise-Wipro
//
//  Created by Ketaki Mahaveer Kurade on 11/10/20.
//

import Foundation
import Alamofire

class NetworkConnectivityManager {
    class var isConnectedToInternet : Bool {
        return NetworkReachabilityManager()!.isReachable
    }
}
