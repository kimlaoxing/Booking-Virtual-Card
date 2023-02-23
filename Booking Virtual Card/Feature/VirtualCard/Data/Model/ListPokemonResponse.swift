import Foundation
import Components

public struct ListPokemonResponse: Codable {
    public let count: Int?
    public let next: String?
    public let results: [Result]?

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.count = try container.decodeWrapper(key: .count, defaultValue: 0)
        self.results = try container.decodeWrapper(key: .results, defaultValue: nil)
        self.next = try container.decodeWrapper(key: .next, defaultValue: "")
    }
    
    public struct Result: Codable {
        public let name: String?
        public let url: String?

        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.name = try container.decodeWrapper(key: .name, defaultValue: "")
            self.url = try container.decodeWrapper(key: .url, defaultValue: "")
        }
    }
}
