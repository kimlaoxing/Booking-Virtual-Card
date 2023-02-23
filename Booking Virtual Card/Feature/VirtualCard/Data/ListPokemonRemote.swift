import Foundation
import Alamofire
import Components

protocol ListPokemonRemoteDataSourceProtocol: AnyObject {
    func getListPokemon(with limit: Int, completion: @escaping (Result<ListPokemonResponse, Error>) -> Void)
}

final class ListPokemonRemoteDataSource: NSObject {
    private override init () {}
    
    static let sharedInstance: ListPokemonRemoteDataSource = ListPokemonRemoteDataSource()
}

extension ListPokemonRemoteDataSource: ListPokemonRemoteDataSourceProtocol {
    
    func getListPokemon(with limit: Int, completion: @escaping (Result<ListPokemonResponse, Error>) -> Void) {
        let endpoint = "\(APIService.basePath)pokemon/"
        let parameters: Parameters = [ "limit": "\(limit)" ]
        AF.request(endpoint,
                   method: .get,
                   parameters: parameters,
                   encoding: URLEncoding.queryString
        )
            .validate(statusCode: 200..<300)
            .responseDecodable(of: ListPokemonResponse.self) { data in
                switch data.result {
                case .success(let data):
                    completion(.success(data))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
}
