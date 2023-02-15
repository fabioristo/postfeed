//
//  PostFeedListView.swift
//  PostFeed
//
//  Created by Fabio Ristoratore on 15/02/23.
//

import SwiftUI

struct PostFeedListView: View {
    @State private var path: [PostModel] = []
    private var posts: [PostModel] = [PostModel(name: "First Post", text: "")]
    
    var body: some View {
        NavigationStack(path: $path) {
            List {
                ForEach(posts) { item in
                    ZStack {
                        NavigationLink(value: item) {
                            EmptyView()
                        }
                        .buttonStyle(PlainButtonStyle())
                        .opacity(0) // For hiding the right arrow
                        
                        VStack(spacing: 0) {
                            Text("VStack")
                            Text(item.name)
                        }
                    }
                }
            }
            .navigationTitle("PostFeed")
            .scrollIndicators(ScrollIndicatorVisibility.never, axes: .vertical)
            .navigationDestination(for: PostModel.self) { model in
                PostFeedView(model: model)
            }
        }
    }
}

struct PostFeedListView_Previews: PreviewProvider {
    static var previews: some View {
        PostFeedListView()
    }
}
