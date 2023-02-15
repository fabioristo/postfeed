//
//  PostFeedResponse.swift
//  PostFeed
//
//  Created by Fabio Ristoratore on 15/02/23.
//

import Foundation

// MARK: - PostFeedResponse
struct PostFeedResponse: Codable {
    let pagination: Pagination
    let statusCode: Int
    let result: [PostModel]
}

// MARK: - Pagination
struct Pagination: Codable {
    let totalCount: Int
    let pageSize: Int
    let currentPage: Int
    let totalPages: Int
    let hasNext: Bool
    let hasPrevious: Bool
}
