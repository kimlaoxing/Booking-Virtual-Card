import Foundation
import Components

protocol VirtualCardViewModelInput {
    func viewDidLoad()
    func getListPokemon()
}

protocol VirtualCardViewModelOutput {
    var listPokemon: Observable<[ListAreaResult]> { get }
    var baseViewState: Observable<BaseViewState?> { get }
    var error: Observable<String?> { get }
}

protocol VirtualCardViewModel: VirtualCardViewModelInput, VirtualCardViewModelOutput {}

final class DefaultVirtualCardViewModel: VirtualCardViewModel {
    let baseViewState: Observable<BaseViewState?> = Observable(.loading)
    let error: Observable<String?> = Observable("")
    let listPokemon: Observable<[ListAreaResult]> = Observable([])
    let useCase: VirtualCardUseCaseProtocol
    
    init(useCase: VirtualCardUseCaseProtocol) {
        self.useCase = useCase
    }
    
    func viewDidLoad() {
        self.getListPokemon()
    }
}

extension DefaultVirtualCardViewModel {
    func getListPokemon() {
        self.baseViewState.value = .loading
        self.useCase.getListArea() { [weak self] data in
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
