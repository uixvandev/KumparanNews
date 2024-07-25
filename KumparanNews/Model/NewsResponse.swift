//
//  NewsResponse.swift
//  KumparanNews
//
//  Created by irfan wahendra on 24/07/24.
//

import Foundation

struct NewsResponse: Decodable {
    var messages: String
    var total: Int
    var data: [NewsArticle]
}

struct NewsArticle: Decodable, Identifiable {
    var id: String {link}
    var creator, title, link, isoDate, description: String
    var categories: [String]
    var image: NewsImage

    struct NewsImage: Decodable {
        var small: String
    }
    
}


