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
    private var allPosts: [PostModel] = []
    
    func fetchPosts() async throws {
        allPosts = try await PostFeedService().loadPosts()
        posts += allPosts.filter({ $0.type == .image })
    }
}
