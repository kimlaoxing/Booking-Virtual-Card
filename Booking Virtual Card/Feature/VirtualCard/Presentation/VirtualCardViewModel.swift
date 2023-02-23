import Foundation
import Components

protocol VirtualCardViewModelInput {
    func viewDidLoad()
    func getListPokemon()
}

protocol VirtualCardViewModelOutput {
    var listPokemon: Observable<[ListPokemonResult]> { get }
    var baseViewState: Observable<BaseViewState?> { get }
    var error: Observable<String?> { get }
}

protocol VirtualCardViewModel: VirtualCardViewModelInput, VirtualCardViewModelOutput {}

final class DefaultVirtualCardViewModel: VirtualCardViewModel {
    let baseViewState: Observable<BaseViewState?> = Observable(.loading)
    let error: Observable<String?> = Observable("")
    let listPokemon: Observable<[ListPokemonResult]> = Observable([])
    let useCase: ListPokemonUseCaseProtocol
    
    init(useCase: ListPokemonUseCaseProtocol) {
        self.useCase = useCase
    }
    
    func viewDidLoad() {
        self.getListPokemon()
    }
}

extension DefaultVirtualCardViewModel {
    func getListPokemon() {
        self.baseViewState.value = .loading
        self.useCase.getListPokemon(with: 20) { [weak self] data in
            switch data {
            case .success(let data):
                self?.baseViewState.value = .normal
                self?.listPokemon.value = data
            case .failure(let error):
                self?.error.value = "\(error)"
            }
        }
    }
}
