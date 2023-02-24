import Foundation
import Components

protocol VirtualCardViewModelInput {
    func viewDidLoad()
    func getListArea()
}

protocol VirtualCardViewModelOutput {
    var listArea: Observable<[ListAreaResult]> { get }
    var baseViewState: Observable<BaseViewState?> { get }
    var error: Observable<String?> { get }
}

protocol VirtualCardViewModel: VirtualCardViewModelInput, VirtualCardViewModelOutput {}

final class DefaultVirtualCardViewModel: VirtualCardViewModel {
    let baseViewState: Observable<BaseViewState?> = Observable(.loading)
    let error: Observable<String?> = Observable("")
    let listArea: Observable<[ListAreaResult]> = Observable([])
    let useCase: VirtualCardUseCaseProtocol
    
    init(useCase: VirtualCardUseCaseProtocol) {
        self.useCase = useCase
    }
    
    func viewDidLoad() {
        self.getListArea()
    }
}

extension DefaultVirtualCardViewModel {
    func getListArea() {
        self.baseViewState.value = .loading
        self.useCase.getListArea() { [weak self] data in
            switch data {
            case .success(let data):
                self?.baseViewState.value = .normal
                self?.listArea.value = data
            case .failure(let error):
                self?.error.value = "\(error)"
            }
        }
    }
}
