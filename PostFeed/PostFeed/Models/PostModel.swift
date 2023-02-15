//
//  PostModel.swift
//  PostFeed
//
//  Created by Fabio Ristoratore on 15/02/23.
//

import Foundation

// MARK: - PostModel
struct PostModel: Hashable, Identifiable, Codable {
    let id: String
    let caption: String
    let type: PostType
    let date: String
    let user: User
    let reactions: Reactions
    let mediaItems: [MediaItem]
}

// MARK: - PostType
enum PostType: String, Codable {
    case image = "image"
    case video = "video"
}

// MARK: - User
struct User: Hashable, Identifiable, Codable {
    let id: String
    let username: String
    let name: String
    let pictureUrl: String
}

// MARK: - Reactions
struct Reactions: Hashable, Codable {
    let totalReactionsCount: Int
    let likesCount: Int
}

// MARK: - MediaItem
struct MediaItem: Hashable, Codable {
    let type: MediaItemType
    let mediaEndpoint: String
    let thumbnailPath: URL
    let size: Size
    let scale: Int
    let aspectRatio: Int
}

// MARK: - MediaItemType
enum MediaItemType: String, Hashable, Codable {
    case photo = "photo"
    case video = "video"
}

// MARK: - Size
struct Size: Hashable, Codable {
    let width: Int
    let height: Int
}
