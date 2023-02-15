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
        Text(model.name)
    }
}

struct PostFeedView_Previews: PreviewProvider {
    static var previews: some View {
        PostFeedView(model: PostModel(name: "Name", text: ""))
    }
}
