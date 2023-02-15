//
//  PostFeedView.swift
//  PostFeed
//
//  Created by Fabio Ristoratore on 15/02/23.
//

import SwiftUI

struct PostFeedView: View {
    let model: PostModel
    var body: some View {
        Text(model.caption)
    }
}

struct PostFeedView_Previews: PreviewProvider {
    static var previews: some View {
        PostFeedView(
            model: PostModel(
                id: "01",
                caption: "Caption",
                type: .image,
                date: "",
                user: User(
                    id: "",
                    username: "",
                    name: "",
                    pictureUrl: ""
                ),
                reactions: Reactions(
                    totalReactionsCount: 1,
                    likesCount: 5
                )
            )
        )
    }
}
