import Foundation

final class VirtualCardInjection: NSObject {
    
    private func provideRepository() -> AreaForSTIDRepositoryProtocol {
        let remote: AreaForSTIDRemoteDataSource = AreaForSTIDRemoteDataSource.sharedInstance
        return AreaForSTIDRepository.sharedInstance(remote)
    }
    
    func provideBase() -> VirtualCardUseCaseProtocol {
        let repository = provideRepository()
        return VirtualCardInteractor(repository: repository)
    }
}
