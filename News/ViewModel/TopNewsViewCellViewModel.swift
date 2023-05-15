//
//  TopNewsViewCellViewModel.swift
//  News
//
//  Created by Wilson Mungai on 2023-02-25.
//

import Foundation

class TopNewsViewCellViewModel {
    let title: String
    let source: String
    let date: String
    let imageUrl: URL?
    let imageData: Data? = nil
    
    init(title: String,
         source: String,
         imageUrl: URL?,
         date: String) {
        self.title = title
        self.source = source
        self.imageUrl = imageUrl
        self.date = date
    }
    
    var dateFromString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ" // 2023-05-14T03:06:07Z
        dateFormatter.timeZone = .current
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .short
//        return "\(dateFormatter.date(from: date) ?? Date())"
        return "\(dateFormatter.date(from: date)?.formatted(date: .abbreviated, time: .shortened) ?? "")"
    }
}
