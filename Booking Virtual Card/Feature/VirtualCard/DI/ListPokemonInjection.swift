import Foundation

final class ListPokemonInjection: NSObject {
    
    private func provideRepository() -> ListPokemonRepositoryProtocol {
        let remote: ListPokemonRemoteDataSource = ListPokemonRemoteDataSource.sharedInstance
        return ListPokemonRepository.sharedInstance(remote)
    }
    
    func provideBase() -> ListPokemonUseCaseProtocol {
        let repository = provideRepository()
        return ListPokemonInteractor(repository: repository)
    }
}

