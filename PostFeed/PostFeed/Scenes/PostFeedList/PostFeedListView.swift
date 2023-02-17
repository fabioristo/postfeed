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
            if store.state == .error {
                ErrorView(
                    error: store.errorType?.errorDescription ?? "",
                    onButtonTapped: store.fetchPosts
                )
                .navigationTitle("PostFeed")
            } else {
                List(store.posts) { post in
                    CellView(post: post)
                        .listRowSeparator(.hidden)
                        .padding(.bottom, 8)
                        .onAppear {
                            if post.id == (store.posts.last?.id ?? "")  {
                                Task { await store.fetchPosts() }
                            }
                        }
                }
                .listStyle(PlainListStyle())
                .navigationTitle("PostFeed")
                .scrollIndicators(ScrollIndicatorVisibility.never, axes: .vertical)
                .navigationDestination(for: PostModel.self) { model in
                    PostFeedView(model: model)
                }
            }
        }
        .task {
            await store.fetchPosts()
        }
    }
}

private struct CellView: View {
    let post: PostModel
    
    var body: some View {
        ZStack {
            NavigationLink(value: post) {
                EmptyView()
            }
            .buttonStyle(PlainButtonStyle())
            .opacity(0) // For hiding the right arrow
            
            HStack(spacing: 8) {
                AsyncImage(url: post.mediaItems.first?.thumbnailPath) { phase in
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
                .frame(width: 100, height: 100)
                .clipShape(RoundedRectangle(cornerRadius: 16))
                
                VStack(alignment: .leading, spacing: 0) {
                    Text(post.user.name)
                        .bold()
                    
                    Text(post.localizedDate)
                        .font(Font.system(.footnote))
                        .padding(.top, 16)
                    
                    Text("Likes: \(post.reactions.likesCount)")
                        .font(Font.system(.footnote))
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(RoundedRectangle(cornerRadius: 16).foregroundColor(.white))
            .shadow(radius: 8, y: 4)
        }
    }
}

private struct ErrorView: View {
    let error: String
    let onButtonTapped: () async -> Void
    
    var body: some View {
        VStack(spacing: 16) {
            Text(error)
            
            Button {
                Task { await onButtonTapped() }
            } label: {
                Text("Refresh")
            }
        }
    }
}

struct PostFeedListView_Previews: PreviewProvider {
    static var previews: some View {
        PostFeedListView()
    }
}
