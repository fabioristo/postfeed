//
//  PostFeedView.swift
//  PostFeed
//
//  Created by Fabio Ristoratore on 15/02/23.
//

import SwiftUI

struct PostFeedView: View {
    let model: PostModel
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            Text(model.user.name)
                .font(.largeTitle)
                .padding(.bottom, 8)
            
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))], spacing: 8) {
                ForEach(model.mediaItems, id: \.self) { item in
                    MediaImage(url: item.mediaEndpoint)
                        .shadow(radius: 8, y: 4)
                }
            }
            .padding(.horizontal, 8)
        }
        .frame(alignment: .top)
    }
}

private struct MediaImage: View {
    let url: URL?
    var body: some View {
        AsyncImage(url: url) { phase in
            switch phase {
            case .failure(_): Color.red
            case .success(let image):
                image
                    .resizable()
                    .scaledToFill()
            case .empty: Color.gray
            default: ProgressView()
            }
        }
    }
}

struct PostFeedView_Previews: PreviewProvider {
    static var previews: some View {
        PostFeedView(
            model: PostModel(
                id: "01",
                caption: "Caption",
                type: .image,
                date: "",
                user: User(
                    id: "",
                    username: "",
                    name: "",
                    pictureUrl: ""
                ),
                reactions: Reactions(
                    totalReactionsCount: 1,
                    likesCount: 5
                ),
                mediaItems: []
            )
        )
    }
}
