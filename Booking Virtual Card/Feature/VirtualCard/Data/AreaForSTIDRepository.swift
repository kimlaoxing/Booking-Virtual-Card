import Foundation

protocol AreaForSTIDRepositoryProtocol {
    func getListArea(completion: @escaping (Result<[ListAreaResult], Error>) -> Void)
    func postCreatEvent(with idno: String,
                        startDate: String,
                        endDate: String,
                        areaIds: [String],
                        completion: @escaping (Result<Data, Error>) -> Void)
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
    func postCreatEvent(with idno: String, startDate: String, endDate: String, areaIds: [String], completion: @escaping (Result<Data, Error>) -> Void) {
        self.remote.postCreatEvent(with: idno, startDate: startDate, endDate: endDate, areaIds: areaIds) { data in
            switch data {
            case .failure(let error):
                completion(.failure(error))
            case .success(let data):
                completion(.success(data))
            }
        }
    }
    
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
