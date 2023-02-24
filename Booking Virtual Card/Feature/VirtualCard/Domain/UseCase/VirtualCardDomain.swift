import Foundation

protocol VirtualCardUseCaseProtocol {
    func getListArea(completion: @escaping (Result<[ListAreaResult], Error>) -> Void)
    func postCreatEvent(with idno: String,
                        startDate: String,
                        endDate: String,
                        areaIds: [String],
                        completion: @escaping (Result<Data, Error>) -> Void)
}

class VirtualCardInteractor: VirtualCardUseCaseProtocol {

    private let repository: AreaForSTIDRepositoryProtocol
    
    required init(repository: AreaForSTIDRepositoryProtocol) {
        self.repository = repository
    }
    
    func getListArea(completion: @escaping (Result<[ListAreaResult], Error>) -> Void) {
        self.repository.getListArea() { data in
            switch data {
            case .failure(let error):
                completion(.failure(error))
            case .success(let data):
                completion(.success(data))
            }
        }
    }
    
    func postCreatEvent(with idno: String,
                        startDate: String,
                        endDate: String,
                        areaIds: [String],
                        completion: @escaping (Result<Data, Error>) -> Void) {
        self.repository.postCreatEvent(with: idno, startDate: startDate, endDate: endDate, areaIds: areaIds) { data in
            switch data {
            case .failure(let error):
                completion(.failure(error))
            case .success(let data):
                completion(.success(data))
            }
        }
    }
}
