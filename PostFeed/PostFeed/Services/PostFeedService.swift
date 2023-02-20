//
//  PostFeedService.swift
//  PostFeed
//
//  Created by Fabio Ristoratore on 15/02/23.
//

import Foundation

final class PostFeedService {
    
    private static var skip: Int = 0
    private let limit: Int = 20
    
    private let token = "eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJuYW1laWQiOiI3YmNjMzZlNy05MDk2LTRkNjEtYjBiZi0wYThiMzBkMTQ1M2YiLCJnaXZlbl9uYW1lIjoiVGF0YXR1IiwiZmFtaWx5X25hbWUiOiJUZXN0IFVzZXIiLCJVc2VyUm9sZSI6InVzZXIiLCJhdXRoVHlwZSI6ImN1c3RvbSIsIm0iOiJwMXJIdGl1MTJTREs3WGN4bUpFMU9oYTVpRkdzNFA3bDZtVW1HaStwa0x0bTdodGlraVhXVUZlcEkwcVpUbmVxIiwiaHR0cHM6Ly9jb3VudHJ5IjoiUlMiLCJUYXRhdHVEYlVzZXJJZCI6IjYzZTI1MGI2NmU0ZDZkNjI5OTliYWQ2NSIsIm5iZiI6MTY3NTc3ODA5NywiZXhwIjoxNjc2NjQyMDk3LCJpYXQiOjE2NzU3NzgwOTcsImlzcyI6Imh0dHBzOi8vc2VydmljZXMtZGV2LnRhdGF0dS5jb20vIiwiYXVkIjoiaHR0cHM6Ly9zZXJ2aWNlcy1kZXYudGF0YXR1LmNvbS8ifQ.L7NiIw8DGxvwHivNOR9-drZotKmwDfb8B9y2piAW4k9kBEM91g6lDvuIOB-6cl6ft_O1uj8Rd3A4Wws4guVmxjao2szNykjxUgUI8aKXT82E0iSAmta6OxFQ1GHE6Y3R7jqfDFVaNbl8slTBMzEDHspVEFj-H5mjwJEnjFCk5aVylbaYb1WiGet3x94sxUsrJKaTQE-cxuJ6lwXi_Lotx6dxbc7nHCPGHY_9hh5gFtdANHEVtPv-ZqNIfrnuvkFioM8XG2yAf-WD5N0RQAqK9azE0LszJXyNVpo4pN35ZEWbmVlaKTPu8hTb9ggyABVOa5aaz3NoiB6Ll7GkgEcHqA"
    
    func loadPosts() async throws -> PostFeedResponse? {
        
        guard let url = URL(string: "https://services-dev.tatatu.com/postsvc/v1.0/timelines/home?skip=\(Self.skip)&limit=\(limit)") else { throw ErrorType.badUrl }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        let (data, httpResponse) = try await URLSession.shared.data(for: request)
        try Task.checkCancellation()
        guard let response = httpResponse as? HTTPURLResponse else { throw ErrorType.responseError }
        guard response.statusCode == 200 else {
            switch response.statusCode {
            case 401: throw ErrorType.unauthorized
            default: throw ErrorType.responseError
            }
        }
        let postFeedResponse = try? JSONDecoder().decode(PostFeedResponse.self, from: data)
        Self.skip += limit
        return postFeedResponse
    }
}
