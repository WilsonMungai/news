//
//  APICaller.swift
//  News
//
//  Created by Wilson Mungai on 2023-02-25.
//

import Foundation
// Responsible for netwrok calls
class APICaller {
    
    // singleton
    static let shared = APICaller()
    
    // fetch top tech news
    func getTopCanadianNews(completion: @escaping (Result<[Article], Error>) -> Void) {
        guard let url = URL(string: "\(Constants.baseUrl)/v2/everything?domains=techcrunch.com,thenextweb.com&apiKey=\(Constants.APIKey)") else {return}
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            do {
                let result = try JSONDecoder().decode(ArticleResponse.self, from: data)
                completion(.success(result.articles))
            } catch {
                completion(.failure(AppError.failedToGetData))
            }
        }
        task.resume()
    }
    
    // fetching latest apple news
    func getLatestAppleNews(with date: String, completion: @escaping (Result<[Article], Error>) -> Void) {
        // fetch news by date
        let date = Date().dayBefore.formatted(.dateTime
            .month(.twoDigits).year().day())
        guard let url = URL(string: "\(Constants.baseUrl)/v2/everything?q=apple&from=\(date)&to=\(date)&sortBy=popularity&apiKey=\(Constants.APIKey)") else {return}

        //url session
        let task = URLSession.shared.dataTask(with: url) { data, _ , error in
            guard let data = data, error == nil else { return }
            do {
                let result = try JSONDecoder().decode(ArticleResponse.self, from: data)
                completion(.success(result.articles))
            } catch {
                completion(.failure(AppError.failedToGetData))
            }
        }
        // resume task from suspended state
        task.resume()
    }
    
    // search news with user query
    func search(with query: String, completion: @escaping (Result<[Article], Error>) -> Void ) {
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else { return }
        guard let url = URL(string: "\(Constants.baseUrl)/v2/everything?q=\(query)&apiKey=\(Constants.APIKey)") else {return}
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            do {
                let result = try JSONDecoder().decode(ArticleResponse.self, from: data)
                completion(.success(result.articles))
            } catch {
                completion(.failure(AppError.failedToGetData))
            }
        }
        task.resume()
    }
}

