//
//  PostModel.swift
//  PostFeed
//
//  Created by Fabio Ristoratore on 15/02/23.
//

import Foundation

struct PostModel: Hashable, Identifiable {
    let id: UUID = UUID()
    let name: String
    let text: String
}
