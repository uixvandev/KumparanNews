//
//  NewsCard.swift
//  KumparanNews
//
//  Created by irfan wahendra on 25/07/24.
//

import SwiftUI

struct NewsCard: View {
    let article : NewsArticle
    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .top, spacing: 8){
                let url = URL(string: article.image.small)
                VStack(alignment: .leading, spacing: 8) {
                    Text(article.title)
                        .font(.headline)
                        .foregroundColor(.black)
                        .lineLimit(3)
                    HStack{
                        ForEach(article.categories, id: \.self) { category in
                            Text(category)
                                .font(.subheadline)
                                .foregroundStyle(.red)
                        }
                        Text("-")
                            .foregroundStyle(.gray)
                        Text(article.isoDate.toRelativeDate())
                            .font(.subheadline)
                            .foregroundStyle(.gray)
                        
                    }
                }
                Spacer()
                AsyncImage(url: url) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                    case .success(let image):
                        image.resizable()
                            .scaledToFill()
                    case .failure(let error):
                        VStack {
                            Image(systemName: "photo.fill")
                                .resizable()
                            Text("Error loading image: \(error.localizedDescription)")
                        }
                    @unknown default:
                        fatalError()
                    }
                }
                .frame(width: 120, height: 100)
                .clipShape(RoundedRectangle(cornerRadius: 10))
            }
        }
        
        
        
    }
}

#Preview {
    NewsCard(article: NewsArticle(creator: "Irfan Wahendra", title: "Bintang Tenis Coco Gauff akan Dampingi LeBron James Bawa Bendera AS di Pembukaan Olimpiade", link: "https:republika.com/", isoDate: "2024-07-24T17:00:03.000Z", description: "Korea Pavilion di FHI 2024. Foto: Istimewa안녕하세여, 친구들 (Annyeonghaseyo, chingudeul)...Makanan Korea telah menjadi kegemaran masyarakat Indonesia dibuktikan dengan banyaknya restoran-hingga produk makanan dari Korea. Cap halal pun kini sudah...", categories: ["Chingudeul"], image: NewsArticle.NewsImage(small:  "https://static.republika.co.id/uploads/images/detailnews/011120300-1721840403-mwcmgv63ntjpg.jpg")))
}


extension String {
    func toRelativeDate() -> String {
        let isoDateFormatter = ISO8601DateFormatter()
        isoDateFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        if let date = isoDateFormatter.date(from: self) {
            let relativeFormatter = RelativeDateTimeFormatter()
            relativeFormatter.unitsStyle = .full
            return relativeFormatter.localizedString(for: date, relativeTo: Date())
        }
        return "Invalid date"
    }
}
