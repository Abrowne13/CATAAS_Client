//
//  ContentViewModel.swift
//  CATAAS Client
//
//  Created by Ahmed Browne on 11/15/22.
//

import Foundation
import Combine

public class ContentViewModel: ObservableObject  {
    
    @Published var cats: [Cat] = []
    
    init() {
        catRequest()
    }
    
    func catRequest() {
        var cats: [Cat] = []
        let url = URL(string: "https://cataas.com/api/cats?&limit=10")!
        var request: URLRequest = URLRequest(url: url)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "GET"
        var catData = Data()
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            print(String(describing:response))
            if let data = data {
                catData = data
                let decoder = JSONDecoder()
                do {
                    cats = try decoder.decode([Cat].self, from: catData)
                    DispatchQueue.main.async {
                        self.cats = cats
                    }
                } catch {
                    print(String(describing: error))
                    DispatchQueue.main.async {
                        self.cats = cats
                    }
                }
                
            } else {
                print(String(describing: error))
                DispatchQueue.main.async {
                    self.cats = []
                }
            }
        }
        task.resume()
    }
}
