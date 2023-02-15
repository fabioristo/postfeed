//
//  PostFeedStore.swift
//  PostFeed
//
//  Created by Fabio Ristoratore on 15/02/23.
//

import Foundation

@MainActor
class PostFeedStore: ObservableObject {
    @Published var posts: [PostModel] = []
    
    func fetchPosts() async throws {
        posts = try await PostFeedService().loadPosts()
    }
}
