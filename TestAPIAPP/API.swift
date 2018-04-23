//
//  API.swift
//  TestAPIAPP
//
//  Created by Simizu Yorinori Cintia Y. on 4/21/18.
//  Copyright © 2018 Simizu Yorinori Cintia Y. All rights reserved.
//

import Foundation

var questions: [TrendingModel] = [TrendingModel]()

class API{
    
func getTrending(){
    var questions: [TrendingModel] = []
    let url = URL(string: "https://api.trakt.tv/movies/trending")!
    var request = URLRequest(url: url)
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    request.addValue("2", forHTTPHeaderField: "trakt-api-version")
    request.addValue("459266145b3b24793677649a8114c373e9d0a433a7967d0598cc677e34215523", forHTTPHeaderField: "trakt-api-key")
    
    let task = URLSession.shared.dataTask(with: request) { data, response, error in
        if let response = response, let data = data {
            let jsonData = jsonString.data(encoding: .utf8)!
            let decoder = JSONDecoder()
            let beer = try! decoder.decode(TrendingModel.self, for: jsonData)
        } else {
            print(error ?? "Error")
        }
    }
    
    task.resume()
}

}
