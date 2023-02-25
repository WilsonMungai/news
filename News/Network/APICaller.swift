//
//  APICaller.swift
//  News
//
//  Created by Wilson Mungai on 2023-02-25.
//

import Foundation

//https://newsapi.org/v2/top-headlines?country=ca&category=business&apiKey=2fa5011c5fad471290a59f5494197861

// constants
struct Constants {
    static let APIKey = "2fa5011c5fad471290a59f5494197861"
    static let baseUrl = "https://newsapi.org"
}

class APICaller {
    static let shared = APICaller()
    
    func getTopCanadianNews(completion: @escaping (Result<[Article], Error>) -> Void) {
        // url string
        guard let url = URL(string: "\(Constants.baseUrl)/v2/top-headlines?country=ca&category=business&apiKey=\(Constants.APIKey)") else {return}
        //url session
        let task = URLSession.shared.dataTask(with: url) { data, _ , error in
            guard let data = data, error == nil else { return }
            do {
//                let result  = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)
                let result = try JSONDecoder().decode(ArticleResponse.self, from: data)
                completion(.success(result.articles))
                print(result)
            } catch {
                print(AppError.failedToGetData)
            }
        }
        task.resume()
    }
}

