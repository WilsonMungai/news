//
//  APICaller.swift
//  News
//
//  Created by Wilson Mungai on 2023-02-25.
//

import Foundation

//https://newsapi.org/v2/top-headlines?country=ca&category=business&apiKey=2fa5011c5fad471290a59f5494197861
// https://newsapi.org/v2/everything?q=apple&from=2023/03/23&to=2023/03/23&sortBy=popularity&apiKey=2fa5011c5fad471290a59f5494197861

class APICaller {
    static let shared = APICaller()
    
    func getTopCanadianNews(with date: String, completion: @escaping (Result<[Article], Error>) -> Void) {
//        func getTopCanadianNews(completion: @escaping (Result<[Article], Error>) -> Void) {
        // url string
//        guard let url = URL(string: "\(Constants.baseUrl)/v2/everything?q=apple&from=03/23/2023&to=03/23/2023&sortBy=popularity&apiKey=\(Constants.APIKey)") else {return}
        let date = Date().dayBefore.formatted(.dateTime
            .month(.twoDigits).year().day())
        guard let url = URL(string: "\(Constants.baseUrl)/v2/everything?q=apple&from=\(date)&to=\(date)&sortBy=popularity&apiKey=\(Constants.APIKey)") else {return}

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
        // resume task from suspended state
        task.resume()
    }
}

