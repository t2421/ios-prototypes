//
//  WikipediaAPIClient.swift
//  lib-RxSwift-wikipedia
//
//  Created by taigakiyotaki on 2019/03/26.
//  Copyright © 2019 taigakiyotaki. All rights reserved.
//

import Foundation
import Alamofire

class WikipediaAPIClient : APIClient{
    var url = "https://ja.wikipedia.org/w/api.php?format=json&action=query&list=search"
    
    func getRequest(_ parameters: [String : String]) -> DataRequest {
        return AF.request(
            URL(string: url)!,
            method:.get,
            parameters:parameters,
            encoding:URLEncoding.default,
            headers:nil)
    }
}

protocol APIClient{
    var url: String {get}
    func getRequest(_ parameters: [String : String]) -> DataRequest
}
