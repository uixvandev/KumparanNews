//
//  KumparanNews.swift
//  KumparanNews
//
//  Created by Hidayat Abisena on 11/02/24.
//

import SwiftUI

struct KumparanNews: View {
    @StateObject private var newsVM = NewsViewModel()
    
    var body: some View {
        NavigationStack {
            List {
                LazyVStack {
                    ForEach(newsVM.articles) { article in
                        NewsCard(article: article)
                    }
                }
            }
            .navigationTitle(Constant.ViewTitles.newsTitle)
            .task {
                await newsVM.loadNews()
            }
            .overlay {
                switch newsVM.isLoadingOverlay {
                case .loading:
                    ProgressView().scaleEffect(2)
                case .error(let message):
                    Text(message)
                        .font(.caption)
                        .foregroundColor(.red)
                case .none:
                    EmptyView()
                }
            }
        }
    }
}

#Preview {
    KumparanNews()
}
