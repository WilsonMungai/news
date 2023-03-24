//
//  TopNewsViewCellViewModel.swift
//  News
//
//  Created by Wilson Mungai on 2023-02-25.
//

import Foundation

class TopNewsViewCellViewModel {
    let title: String
//    let description: String
    let source: String
    let imageUrl: URL?
    let imageData: Data? = nil
    
    init(title: String,
//         description: String,
         source: String,
         imageUrl: URL?) {
        self.title = title
//        self.description = description
        self.source = source
        self.imageUrl = imageUrl
    }
}
