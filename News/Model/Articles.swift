//
//  Articles.swift
//  News
//
//  Created by Wilson Mungai on 2023-02-25.
//

import Foundation

// MARK: - Welcome
struct ArticleResponse: Codable {
//    let status: String
//    let totalResults: Int
    let articles: [Article]
}

// MARK: - Article
struct Article: Codable {
    let source: Source
    let author: String?
    let title: String?
    let description: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: String?
    let content: String?
}

// MARK: - Source
struct Source: Codable {
//    let id: ID?
    let name: String
}

//enum ID: String, Codable {
//    case cbcNews = "cbc-news"
//    case googleNews = "google-news"
//    case nhlNews = "nhl-news"
//}

/*
 author = "<null>";
 content = "<null>";
 description = "In this LIVE trading video, we will be providing you with trade ideas every weekday morning from 9am-11am ET.If you're looking to make some money by trading ...";
 publishedAt = "2023-02-24T16:01:37Z";
 source =             {
     id = "<null>";
     name = YouTube;
 };
 title = "LIVE Trading With Benzinga - Benzinga";
 url = "https://www.youtube.com/watch?v=--B0AqVHkk8";
 urlToImage = "https://i.ytimg.com/vi/--B0AqVHkk8/maxresdefault.jpg";
 */
