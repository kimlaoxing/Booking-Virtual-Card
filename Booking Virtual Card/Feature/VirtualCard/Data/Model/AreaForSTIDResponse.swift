import Foundation
import Components

public struct AreaForSTIDResponse: Codable {
    public let id: String?
    public let areaName: String?
    public let floorName: String?
    public let buildingName: String?
    public let location: String?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case areaName = "area_name"
        case floorName = "floor_name"
        case buildingName = "building_name"
        case location = "location"
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decodeWrapper(key: .id, defaultValue: "")
        self.areaName = try container.decodeWrapper(key: .areaName, defaultValue: "")
        self.floorName = try container.decodeWrapper(key: .floorName, defaultValue: "")
        self.buildingName = try container.decodeWrapper(key: .buildingName, defaultValue: "")
        self.location = try container.decodeWrapper(key: .location, defaultValue: "")
    }
}

