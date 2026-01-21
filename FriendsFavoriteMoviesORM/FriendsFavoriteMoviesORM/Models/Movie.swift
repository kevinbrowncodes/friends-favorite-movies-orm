import Foundation
import SwiftData

@Model
class Movie {
    var title: String
    var releaseDate: Date
    var favoritedBy = [Friend]()
    
    init(title: String, releaseDate: Date) {
        self.title = title
        self.releaseDate = releaseDate
    }
    
    static func loadFromBundle() -> [Movie] {
        guard let url = Bundle.main.url(forResource: "Movies", withExtension: "json"),
              let data = try? Data(contentsOf: url) else {
            print("Failed to locate Movies.json in bundle")
            return []
        }
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        
        struct MovieData: Codable {
            let title: String
            let releaseDate: Date
        }
        
        guard let movieData = try? decoder.decode([MovieData].self, from: data) else {
            print("Failed to decode Movies.json")
            return []
        }
        
        return movieData.map { Movie(title: $0.title, releaseDate: $0.releaseDate) }
    }
}
