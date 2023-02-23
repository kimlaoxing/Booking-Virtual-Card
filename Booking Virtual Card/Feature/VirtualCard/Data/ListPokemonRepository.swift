import Foundation

protocol ListPokemonRepositoryProtocol {
    func getListPokemon(with limit: Int, completion: @escaping (Result<[ListPokemonResult], Error>) -> Void)
}

final class ListPokemonRepository: NSObject {
    typealias ListPokemonInstance = (ListPokemonRemoteDataSource) -> ListPokemonRepository
    
    fileprivate let remote: ListPokemonRemoteDataSource
    
    private init(remote: ListPokemonRemoteDataSource) {
        self.remote = remote
    }
    
    static let sharedInstance: ListPokemonInstance = { remoteRepo in
        return ListPokemonRepository(remote: remoteRepo)
    }
}

extension ListPokemonRepository: ListPokemonRepositoryProtocol {
    func getListPokemon(with limit: Int, completion: @escaping (Result<[ListPokemonResult], Error>) -> Void) {
        self.remote.getListPokemon(with: limit) { data in
            switch data {
            case .failure(let error):
                completion(.failure(error))
            case .success(let data):
                completion(.success(ListPokemonMapper.listPokemonMapper(result: data.results ?? [])))
            }
        }
    }
}
