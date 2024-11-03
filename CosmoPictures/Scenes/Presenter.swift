
import Foundation
import Alamofire

enum PresenterState {
    case initial
    case loading
    case failed(Error)
    case data([ResponseModel])
}

protocol Presenter {
    func viewDidLoad()
    func openDetails(with cellModel: CellModel)
}

final class PresenterImpl {
    
    //MARK: - Public properties
    
    weak var view: MainView?
    
    //MARK: - Private properties
    
    private var state = PresenterState.initial {
        didSet {
            stateDidChanged()
        }
    }
}

// MARK: - Public Methods

extension PresenterImpl: Presenter {
    func viewDidLoad() {
        state = .loading
    }
    
    func openDetails(with cellModel: CellModel) {
        let viewController = DetailViewController(presenter: self,
                                                  cellModel: cellModel)
        viewController.modalPresentationStyle = .pageSheet
        view?.present(viewController)
    }
}

// MARK: - Private Methods

private extension PresenterImpl {
    
    func stateDidChanged() {
        switch state {
        case .initial:
            assertionFailure("can't move to initial state")
        case .loading:
            view?.showLoading()
            AFFetch()
        case .data(let data):
            view?.hideLoading()
            let cellModels = data.map { model in
                CellModel(from: model)
            }
            view?.displayCells(cellModels)
        case .failed(let error):
            let errorModel = makeErrorModel(error)
            view?.hideLoading()
            view?.showError(errorModel)
        }
    }
    
    func AFFetch() {
        let parameters = ["api_key" : Constants.apiKey,
                          "count" : Constants.count] as [String : Any]
        AF.request(Constants.host,
                   method: .get,
                   parameters: parameters).response { response in
            switch response.result {
            case .success(let data):
                guard let data = data else { return }
                do {
                    let responseModels = try JSONDecoder().decode(
                        [ResponseModel].self,
                        from: data
                    )
                    self.state = .data(responseModels)
                } catch {
                    self.state = .failed(error)
                }
            case .failure(let error):
                self.state = .failed(error)
            }
        }
    }
    
    func makeErrorModel(_ error: Error) -> ErrorModel {
        let message = error.localizedDescription
        let actionText = "Repeat"
        return ErrorModel(message: message, actionText: actionText) { [weak self] in
            self?.state = .loading
        }
    }
}
