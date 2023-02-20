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
    
    private let token = "eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJuYW1laWQiOiI3YmNjMzZlNy05MDk2LTRkNjEtYjBiZi0wYThiMzBkMTQ1M2YiLCJnaXZlbl9uYW1lIjoiVGF0YXR1IiwiZmFtaWx5X25hbWUiOiJUZXN0IFVzZXIiLCJVc2VyUm9sZSI6InVzZXIiLCJhdXRoVHlwZSI6ImN1c3RvbSIsIm0iOiJwMXJIdGl1MTJTREs3WGN4bUpFMU9oYTVpRkdzNFA3bDZtVW1HaStwa0x0bTdodGlraVhXVUZlcEkwcVpUbmVxIiwiaHR0cHM6Ly9jb3VudHJ5IjoiUlMiLCJUYXRhdHVEYlVzZXJJZCI6IjYzZTI1MGI2NmU0ZDZkNjI5OTliYWQ2NSIsIm5iZiI6MTY3Njg4NjQxOSwiZXhwIjoxNjc3MDU5MjE5LCJpYXQiOjE2NzY4ODY0MTksImlzcyI6Imh0dHBzOi8vc2VydmljZXMtZGV2LnRhdGF0dS5jb20vIiwiYXVkIjoiaHR0cHM6Ly9zZXJ2aWNlcy1kZXYudGF0YXR1LmNvbS8ifQ.a3mR6oxZL6VJmXBxQxFxQRAwUvtj_B4h0hQ6-PHD2cFPP8IjYy1ZT-D74_lkbSxi87aJmOTnf7tq5NyWD5N_MclwunOJEp9OKCPqplGEBBXhfkFbmbMJA9vVcjh8yvmKodLNlI-QBOrlEfrxlRsvF67QgcYO3Ml1Tl3j6FmR_6B77kvfQ6XE-5yzI7KLromizz0OFNQU3r2-iUwmQ5ltlnWAXPns0FNWUtWzmEnsnIidYQn10fSjm3FPfx5i4pM0reIMC0AJki4-YWcp-ciMlGDEok1qFkBGiVwYxUhSe7Mai8hemIRFEdaHwbCLv1iqqtz4bjUTGgKLrDGKpX_C2A"
    
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
