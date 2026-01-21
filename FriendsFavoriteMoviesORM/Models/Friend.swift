import Foundation
import SwiftData

@Model
class Friend {
    var name: String
    
    init(name:String) {
        self.name = name
    }
    
    static let sampleData = [
        Friend(name: "Arthur"),
        Friend(name: "Merlin"),
        Friend(name: "Lancelot"),
        Friend(name: "Percival"),
        Friend(name: "Galahad")
    ]
}

