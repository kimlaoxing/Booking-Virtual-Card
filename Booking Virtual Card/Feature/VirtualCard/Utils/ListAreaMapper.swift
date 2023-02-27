import Foundation

final class ListAreaMapper {
    static func listAreaMapper(response: [AreaForSTIDResponse]) -> [ListAreaResult] {
        return response.map { data in
            return ListAreaResult(id: data.id ?? "",
                                  areaName: data.areaName ?? "",
                                  floorName: data.floorName ?? "",
                                  buildingName: data.buildingName ?? "",
                                  location: data.location ?? "")
        }
    }
}
