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
    var localizedError: String {
        switch errorType {
        case .none:
            return "Generic Error"
        case .badUrl:
            return "Invalid URL"
        case .responseError:
            return "Invalid Response"
        case .unauthorized:
            return "Unauthorized"
        }
    }
    
    func fetchPosts() async {
        guard hasNextPage else { return }
        do {
            state = .loading
            let response = try await PostFeedService().loadPosts()
            hasNextPage = response?.pagination.hasNext ?? false
            allPosts = response?.result ?? []
            posts += allPosts.filter({ $0.type == .image })
            state = .loaded
        } catch {
            errorType = error as? ErrorType
            state = .error
        }
    }
}
