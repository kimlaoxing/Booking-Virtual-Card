import Foundation

protocol AreaForSTIDRepositoryProtocol {
    func getListArea(completion: @escaping (Result<[ListAreaResult], Error>) -> Void)
}

final class AreaForSTIDRepository: NSObject {
    typealias ListPokemonInstance = (AreaForSTIDRemoteDataSource) -> AreaForSTIDRepository
    
    fileprivate let remote: AreaForSTIDRemoteDataSource
    
    private init(remote: AreaForSTIDRemoteDataSource) {
        self.remote = remote
    }
    
    static let sharedInstance: ListPokemonInstance = { remoteRepo in
        return AreaForSTIDRepository(remote: remoteRepo)
    }
}

extension AreaForSTIDRepository: AreaForSTIDRepositoryProtocol {
    func getListArea(completion: @escaping (Result<[ListAreaResult], Error>) -> Void) {
        self.remote.getListArea() { data in
            switch data {
            case .failure(let error):
                completion(.failure(error))
            case .success(let data):
                completion(.success(ListAreaMapper.listAreaMapper(response: data)))
            }
        }
    }
}
