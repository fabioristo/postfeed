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
        ScrollView {
            if model.mediaItems.count > 1 {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 170))]) {
                    ForEach(model.mediaItems, id: \.self) { item in
                        MediaImage(url: item.mediaEndpoint)
                    }
                }
            } else {
                VStack(spacing: 0) {
                    MediaImage(url: model.mediaItems.first?.mediaEndpoint)
                        .frame(maxWidth: .infinity, maxHeight: 300)
                    
                    Text(model.caption)
                        .padding(.top, 16)
                }
            }
            
        }
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
                    .scaledToFit()
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
