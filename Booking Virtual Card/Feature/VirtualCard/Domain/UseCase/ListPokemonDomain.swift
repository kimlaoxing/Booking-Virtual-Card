import Foundation

protocol ListPokemonUseCaseProtocol {
    func getListPokemon(with limit: Int, completion: @escaping (Result<[ListPokemonResult], Error>) -> Void)
}

class ListPokemonInteractor: ListPokemonUseCaseProtocol {

    private let repository: ListPokemonRepositoryProtocol
    
    required init(repository: ListPokemonRepositoryProtocol) {
        self.repository = repository
    }
    
    func getListPokemon(with limit: Int, completion: @escaping (Result<[ListPokemonResult], Error>) -> Void) {
        self.repository.getListPokemon(with: limit) { data in
            switch data {
            case .failure(let error):
                completion(.failure(error))
            case .success(let data):
                completion(.success(data))
            }
        }
    }
}
