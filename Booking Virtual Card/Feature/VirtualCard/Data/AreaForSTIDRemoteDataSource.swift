import Foundation
import Alamofire
import Components

protocol AreaForSTIDRemoteDataSourceProtocol: AnyObject {
    func getListArea(completion: @escaping (Result<[AreaForSTIDResponse], Error>) -> Void)
    func postCreatEvent(with idno: String,
                        startDate: String,
                        endDate: String,
                        areaIds: [String],
                        completion: @escaping (Result<Data, Error>) -> Void)
}

final class AreaForSTIDRemoteDataSource: NSObject {
    private override init () {}
    
    static let sharedInstance: AreaForSTIDRemoteDataSource = AreaForSTIDRemoteDataSource()
}

extension AreaForSTIDRemoteDataSource: AreaForSTIDRemoteDataSourceProtocol {
    func postCreatEvent(with idno: String,
                        startDate: String,
                        endDate: String,
                        areaIds: [String],
                        completion: @escaping (Result<Data, Error>) -> Void) {
        let endpoint = "\(APIService.basePath)stid-event"
        let params: Parameters = [
                "idNo": "\(idno)",
                "startDate": "\(startDate)",
                "endDate": "\(endDate)",
                "areaIds": "\([areaIds])"
            ]
            
        let header: HTTPHeaders = [ "x-api-key" : "2hSpXqoQuXiMGjs9dihUs9XmDfAGAcpH" ]
        AF.request(endpoint,
                   method: .post,
                   parameters: params,
                   encoding: JSONEncoding.default,
                   headers: header
        )
            .validate(statusCode: 200..<300)
            .responseData { response in
                switch response.result {
                case .success(let data):
                    completion(.success(data))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
    
    
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
