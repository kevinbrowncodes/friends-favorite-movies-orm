//
//  FriendsFavoriteMoviesORMApp.swift
//  FriendsFavoriteMoviesORM
//
//  Created by Kevin Brown on 1/21/26.
//

import SwiftUI
import SwiftData

@main
struct FriendsFavoriteMoviesORMApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Friend.self,
            Movie.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            let container = try ModelContainer(for: schema, configurations: [modelConfiguration])
            
            // Check if we need to prepopulate
            let context = container.mainContext
            let movieCount = try context.fetchCount(FetchDescriptor<Movie>())
            let friendCount = try context.fetchCount(FetchDescriptor<Friend>())
            
            if movieCount == 0 {
                // First launch - load all movies from JSON
                for movie in Movie.loadFromBundle() {
                    context.insert(movie)
                }
                try context.save()
            } else {
                // Check for new movies not in database
                let existingMovies = try context.fetch(FetchDescriptor<Movie>())
                let existingTitles = Set(existingMovies.map { $0.title })
                let newMovies = Movie.loadFromBundle().filter { !existingTitles.contains($0.title) }
                
                if !newMovies.isEmpty {
                    for movie in newMovies {
                        context.insert(movie)
                    }
                    try context.save()
                    print("Added \(newMovies.count) new movie(s) from JSON")
                }
            }
            
            if friendCount == 0 {
                // First launch - load all friends from JSON
                for friend in Friend.loadFromBundle() {
                    context.insert(friend)
                }
                try context.save()
            } else {
                // Check for new friends not in database
                let existingFriends = try context.fetch(FetchDescriptor<Friend>())
                let existingNames = Set(existingFriends.map { $0.name })
                let newFriends = Friend.loadFromBundle().filter { !existingNames.contains($0.name) }
                
                if !newFriends.isEmpty {
                    for friend in newFriends {
                        context.insert(friend)
                    }
                    try context.save()
                    print("Added \(newFriends.count) new friend(s) from JSON")
                }
            }
            
            return container
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(sharedModelContainer)
    }
}
