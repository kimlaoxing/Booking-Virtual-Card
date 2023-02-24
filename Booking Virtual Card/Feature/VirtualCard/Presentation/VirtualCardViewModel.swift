import Foundation
import Components

protocol VirtualCardViewModelInput {
    func viewDidLoad()
    func getListArea()
    func postCreatEvent(with idno: String,
                        startDate: String,
                        endDate: String,
                        areaIds: [String])
}

protocol VirtualCardViewModelOutput {
    var listArea: Observable<[ListAreaResult]> { get }
    var baseViewState: Observable<BaseViewState?> { get }
    var error: Observable<String?> { get }
    var creatEventState: Observable<CreatEventState?> { get }
}

protocol VirtualCardViewModel: VirtualCardViewModelInput, VirtualCardViewModelOutput {}

final class DefaultVirtualCardViewModel: VirtualCardViewModel {
 
    let baseViewState: Observable<BaseViewState?> = Observable(.loading)
    let creatEventState: Observable<CreatEventState?> = Observable(.idle)
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
    
    func postCreatEvent(with idno: String, startDate: String, endDate: String, areaIds: [String]) {
        self.useCase.postCreatEvent(with: idno, startDate: startDate, endDate: endDate, areaIds: areaIds) { data in
            switch data {
            case .success(_):
                self.creatEventState.value = .success
            case .failure(_):
                self.creatEventState.value = .failure
            }
        }
    }
}
