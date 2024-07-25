//
//  APIService.swift
//  KumparanNews
//
//  Created by irfan wahendra on 24/07/24.
//

import Foundation
import Alamofire

class APIService {
    static let shared = APIService()
    
    func fetchNews() async throws -> [NewsArticle] {
        let urlString = Constant.newsUrl
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }
        
        //Continuation
        let news = try await withCheckedThrowingContinuation { continuation in
            AF.request(url).responseDecodable(of: NewsResponse.self) { response in
                switch response.result{
                case .success(let newsResponse):
                    continuation.resume(returning: newsResponse.data)
                case .failure(let error):
                    continuation.resume(throwing: error)
                }
            }
        }
        return news
    }
}
