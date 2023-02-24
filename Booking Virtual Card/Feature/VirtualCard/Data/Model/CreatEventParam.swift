import Foundation

public struct CreatEventParam: Codable {
    public let idNo: String?
    public let startDate: String?
    public let endDate: String?
    public let areaIDS: [String]?

    enum CodingKeys: String, CodingKey {
        case idNo = "idNo"
        case startDate = "startDate"
        case endDate = "endDate"
        case areaIDS = "areaIds"
    }

    public init(idNo: String?, startDate: String?, endDate: String?, areaIDS: [String]?) {
        self.idNo = idNo
        self.startDate = startDate
        self.endDate = endDate
        self.areaIDS = areaIDS
    }
}
