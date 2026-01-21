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
    
    static let sampleData = [
        Movie(title: "Lion King", releaseDate: Date(timeIntervalSinceReferenceDate: -20_822_400)),
        Movie(title: "Hercules", releaseDate: Date(timeIntervalSinceReferenceDate: 182_995_200)),
        Movie(title: "Wall-E", releaseDate: Date(timeIntervalSinceReferenceDate: -177_033_600)),
        Movie(title: "Toy Story", releaseDate: Date(timeIntervalSinceReferenceDate: 409_622_400)),
        Movie(title: "Finding Nemo", releaseDate: Date(timeIntervalSinceReferenceDate: 649_296_000))
    ]
}
