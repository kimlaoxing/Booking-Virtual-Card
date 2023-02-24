import Foundation
import Alamofire
import Components

protocol AreaForSTIDRemoteDataSourceProtocol: AnyObject {
    func getListArea(completion: @escaping (Result<[AreaForSTIDResponse], Error>) -> Void)
}

final class AreaForSTIDRemoteDataSource: NSObject {
    private override init () {}
    
    static let sharedInstance: AreaForSTIDRemoteDataSource = AreaForSTIDRemoteDataSource()
}

extension AreaForSTIDRemoteDataSource: AreaForSTIDRemoteDataSourceProtocol {
    
    func getListArea(completion: @escaping (Result<[AreaForSTIDResponse], Error>) -> Void) {
        let endpoint = "\(APIService.basePath)area-for-stid"
        let header: HTTPHeaders = [
            "x-api-key" : "2hSpXqoQuXiMGjs9dihUs9XmDfAGAcpH",
            "Content-Type" : "application/x-www-form-urlencoded" ]
        AF.request(endpoint,
                   method: .get,
                   encoding: JSONEncoding.default,
                   headers: header
        )
            .validate(statusCode: 200..<300)
            .responseDecodable(of: [AreaForSTIDResponse].self) { data in
                switch data.result {
                case .success(let data):
                    completion(.success(data))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
}
