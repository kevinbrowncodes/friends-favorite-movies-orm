import Foundation
import SwiftData

@Model
class Movie {
    var title: String
    var releaseDate: Date
    
    init(title: String, releaseDate: Date) {
        self.title = title
        self.releaseDate = releaseDate
    }
    
    static let sampleData = [
        Movie(title: "Gladiator", releaseDate: Date(timeIntervalSinceReferenceDate: -20_822_400)),
        Movie(title: "The Prestige", releaseDate: Date(timeIntervalSinceReferenceDate: 182_995_200)),
        Movie(title: "Braveheart", releaseDate: Date(timeIntervalSinceReferenceDate: -177_033_600)),
        Movie(title: "The Secret Life of Walter Mitty", releaseDate: Date(timeIntervalSinceReferenceDate: 409_622_400)),
        Movie(title: "The Green Knight", releaseDate: Date(timeIntervalSinceReferenceDate: 649_296_000))
    ]
}
