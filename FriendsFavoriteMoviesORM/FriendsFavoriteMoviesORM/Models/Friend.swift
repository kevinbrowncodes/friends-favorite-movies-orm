import Foundation
import SwiftData

@Model
class Friend {
    var name: String
    var favoriteMovie: Movie?
    
    init(name:String) {
        self.name = name
    }
    
    static func loadFromBundle() -> [Friend] {
        guard let url = Bundle.main.url(forResource: "Friends", withExtension: "json"),
              let data = try? Data(contentsOf: url) else {
            print("Failed to locate Friends.json in bundle")
            return []
        }
        
        let decoder = JSONDecoder()
        
        struct FriendData: Codable {
            let name: String
        }
        
        guard let friendData = try? decoder.decode([FriendData].self, from: data) else {
            print("Failed to decode Friends.json")
            return []
        }
        
        return friendData.map { Friend(name: $0.name) }
    }
}

