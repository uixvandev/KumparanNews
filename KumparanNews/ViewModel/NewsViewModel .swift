//
//  NewsViewModel .swift
//  KumparanNews
//
//  Created by irfan wahendra on 24/07/24.
//

import Foundation

@MainActor
class NewsViewModel: ObservableObject {
    @Published var articles = [NewsArticle]()
    @Published var isLoading = false
    @Published var errorMessage : String?
    
    func loadNews() async {
        isLoading = true
        defer {isLoading = false}
        errorMessage = nil
        
        do {
            articles = try await APIService.shared.fetchNews()
        } catch {
            errorMessage = ("🤣 \(error.localizedDescription) Failed to fetch news from API!!!")
            print(error)
        }
        
    }
    
    enum LoadingOverlayState{
        case loading
        case error(String)
        case none
    }
    
    var isLoadingOverlay:LoadingOverlayState{
        if isLoading {
            return .loading
        } else if let errorMessage = errorMessage, !errorMessage.isEmpty  {
            return .error(errorMessage)
        } else {
            return .none
        }
    }
}
