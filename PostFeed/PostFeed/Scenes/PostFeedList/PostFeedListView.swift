//
//  PostFeedListView.swift
//  PostFeed
//
//  Created by Fabio Ristoratore on 15/02/23.
//

import SwiftUI

struct PostFeedListView: View {
    @State private var path: [PostModel] = []
    @StateObject private var store = PostFeedStore()
    
    var body: some View {
        NavigationStack(path: $path) {
            List(store.posts) { post in
                ZStack {
                    NavigationLink(value: post) {
                        EmptyView()
                    }
                    .buttonStyle(PlainButtonStyle())
                    .opacity(0) // For hiding the right arrow
                    
                    VStack(alignment: .leading, spacing: 0) {
                        Text(post.user.name)
                        HStack(spacing: 8) {
                            AsyncImage(url: post.mediaItems.first?.thumbnailPath) { image in
                                image
                                    .resizable()
                                    .scaledToFit()
                                    .clipShape(RoundedRectangle(cornerRadius: 16))
                            } placeholder: {
                                ProgressView()
                            }
                            .frame(width: 100, height: 100)
                            .clipShape(RoundedRectangle(cornerRadius: 16))
                            
                            Text(post.caption)
                        }                        
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .onAppear {
                        if post.id == (store.posts.last?.id ?? "")  {
                            Task { await getPosts() }
                        }
                    }
                }
            }
            .navigationTitle("PostFeed")
            .scrollIndicators(ScrollIndicatorVisibility.never, axes: .vertical)
            .navigationDestination(for: PostModel.self) { model in
                PostFeedView(model: model)
            }
        }
        .task {
            await getPosts()
        }
    }
    
    private func getPosts() async {
        do {
            try await store.fetchPosts()
        } catch {
            print(error.localizedDescription)
        }
    }
}

struct PostFeedListView_Previews: PreviewProvider {
    static var previews: some View {
        PostFeedListView()
    }
}
