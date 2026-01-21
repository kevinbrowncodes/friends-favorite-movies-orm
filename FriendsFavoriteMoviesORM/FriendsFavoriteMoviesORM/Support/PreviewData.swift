import Foundation
import SwiftData


@MainActor
class PreviewData {
    static let shared = PreviewData()


    let modelContainer: ModelContainer


    var context: ModelContext {
        modelContainer.mainContext
    }
    
    var friend: Friend {
        let friends = try? context.fetch(FetchDescriptor<Friend>())
        return friends?.first ?? Friend(name: "Sample")
    }
    
    var movie: Movie {
        let movies = try? context.fetch(FetchDescriptor<Movie>())
        return movies?.first ?? Movie(title: "Sample", releaseDate: .now)
    }


    private init() {
        let schema = Schema([
            Friend.self,
            Movie.self,
        ])
        
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: true)


        do {
            modelContainer = try ModelContainer(for: schema, configurations: [modelConfiguration])
            
            insertSampleData()
            
            try context.save()
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }
    
    private func insertSampleData() {
        // Load friends from JSON file - same data source as the real app
        let friends = Friend.loadFromBundle()
        for friend in friends {
            context.insert(friend)
        }
        
        // Load movies from JSON file - same data source as the real app
        let movies = Movie.loadFromBundle()
        for movie in movies {
            context.insert(movie)
        }
        
        // Set up relationships using loaded data
        if movies.count >= 5 && friends.count >= 5 {
            friends[0].favoriteMovie = movies[0]
            friends[0].favoriteMovie = movies[1]
            friends[0].favoriteMovie = movies[2]
            friends[0].favoriteMovie = movies[3]
            friends[0].favoriteMovie = movies[4]
            friends[2].favoriteMovie = movies[0]
            friends[3].favoriteMovie = movies[4]
            friends[4].favoriteMovie = movies[0]
        }
    }
}
