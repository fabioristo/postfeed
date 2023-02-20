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
    @Published var errorType: ErrorType?
    @Published var state: StoreState = .loading
    private var allPosts: [PostModel] = []
    private var hasNextPage: Bool = true
    
    func fetchPosts() async {
        errorType = nil
        guard hasNextPage else { return }
        do {
            state = .loading
            let response = try await PostFeedService().loadPosts()
            hasNextPage = response?.pagination.hasNext ?? false
            allPosts = response?.result ?? []
            posts += allPosts.filter({ $0.type == .image || $0.type == .multimedia })
            state = .loaded
        } catch {
            errorType = error as? ErrorType
            state = .error
        }
    }
}
